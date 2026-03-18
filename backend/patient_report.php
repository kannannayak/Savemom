<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

include_once 'config/database.php';

$database = new Database();
$db = $database->getConnection();

// Normalize date to yyyy-mm-dd
function normalizeDate($dateStr) {
    if (preg_match('/^\d{2}-\d{2}-\d{4}$/', $dateStr)) {
        $parts = explode('-', $dateStr);
        return $parts[2] . '-' . $parts[1] . '-' . $parts[0]; // yyyy-mm-dd
    }
    return $dateStr;
}

// Generate random string
function generateShortId($length = 5) {
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $shortId = '';
    for ($i = 0; $i < $length; $i++) {
        $shortId .= $chars[random_int(0, strlen($chars) - 1)];
    }
    return $shortId;
}

function generateShortFilename($originalName) {
    $ext = pathinfo($originalName, PATHINFO_EXTENSION);
    return generateShortId() . '.' . $ext;
}

// Upload logic
function uploadFiles($inputName, $uploadDir) {
    $uploaded = [];

    if (!isset($_FILES[$inputName])) {
        return $uploaded;
    }

    $files = $_FILES[$inputName];

    if (!is_array($files['name'])) {
        $files = [
            'name' => [$files['name']],
            'type' => [$files['type']],
            'tmp_name' => [$files['tmp_name']],
            'error' => [$files['error']],
            'size' => [$files['size']]
        ];
    }

    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    for ($i = 0; $i < count($files['name']); $i++) {
        if ($files['error'][$i] === UPLOAD_ERR_OK) {
            $originalName = basename($files['name'][$i]);

            do {
                $uniqueName = generateShortFilename($originalName);
                $destination = $uploadDir . DIRECTORY_SEPARATOR . $uniqueName;
            } while (file_exists($destination));

            if (move_uploaded_file($files['tmp_name'][$i], $destination)) {
                $uploaded[] = $uniqueName;
            }
        }
    }

    return $uploaded;
}

// Input values
$p_id = $_POST['p_id'] ?? null;
$r_id = $_POST['r_id'] ?? null;
$p_date = isset($_POST['p_date']) ? normalizeDate($_POST['p_date']) : date('Y-m-d');

if (!$p_id) {
    echo json_encode(["status" => false, "message" => "p_id is required."]);
    exit();
}

if ($r_id) {
    $stmt = $db->prepare("SELECT COUNT(*) FROM patient_relationships WHERE p_id = ? AND r_id = ?");
    $stmt->execute([$p_id, $r_id]);
    if ($stmt->fetchColumn() == 0) {
        echo json_encode(["status" => false, "message" => "Patient Relation is not valid."]);
        exit();
    }
}

$uploadFields = [
    'scan_cam_image' => 'scan',
    'scan_gallery_image' => 'scan',
    'scan_pdf_upload' => 'scan',
    'lab_cam_image' => 'lab',
    'lab_gallery_image' => 'lab',
    'lab_pdf_upload' => 'lab',
    'prescription_cam_image' => 'prescription',
    'prescription_gallery_image' => 'prescription',
    'prescription_pdf_upload' => 'prescription',
    'discharge_cam_image' => 'discharge',
    'discharge_gallery_image' => 'discharge',
    'discharge_pdf_upload' => 'discharge',
    'other_cam_image' => 'other',
    'other_gallery_image' => 'other',
    'other_pdf_upload' => 'other',
];

try {
    $db->beginTransaction();

    // Insert into patient_reports
    $columns = ['p_id', 'p_date', 'created_at'];
    $placeholders = ['?', '?', 'NOW()'];
    $values = [$p_id, $p_date];

    if ($r_id) {
        $columns[] = 'r_id';
        $placeholders[] = '?';
        $values[] = $r_id;
    }

    $sql = "INSERT INTO patient_reports (" . implode(',', $columns) . ") VALUES (" . implode(',', $placeholders) . ")";
    $stmt = $db->prepare($sql);
    $stmt->execute($values);
    $report_id = $db->lastInsertId();

    // Prepare insert for scan files
    $insertScanFile = $db->prepare("
        INSERT INTO patient_scan_files (sno, p_id, r_id, report_id, p_date, file_name, file_path, type)
        VALUES (:sno, :p_id, :r_id, :report_id, :p_date, :file_name, :file_path, :type)
    ");

    $sno = 1;
    $uploadedAll = [];

    $categoryFolders = [];

    foreach ($uploadFields as $field => $category) {
        // Create folder ONCE per category per hit
        if (!isset($categoryFolders[$category])) {
            $uniqueSuffix = generateShortId();
            $folderName = "uploads/{$category}/{$category}_p{$p_id}_{$p_date}_{$uniqueSuffix}";
            $categoryFolders[$category] = $folderName;
        }

        $folder = $categoryFolders[$category];
        $files = uploadFiles($field, $folder);

        foreach ($files as $file) {
            $insertScanFile->execute([
                ':sno' => $sno++,
                ':p_id' => $p_id,
                ':r_id' => $r_id,
                ':report_id' => $report_id,
                ':p_date' => $p_date,
                ':file_name' => $file,
                ':file_path' => $folder . '/',
                ':type' => $field
            ]);
        }

        if (!empty($files)) {
            $uploadedAll[$field] = $files;
        }
    }

    $db->commit();

    echo json_encode([
        "status" => true,
        "message" => "Files uploaded and saved successfully with one folder per category.",
        "report_id" => $report_id,
        "folders_used" => $categoryFolders,
        "uploaded_files" => $uploadedAll
    ]);

} catch (PDOException $e) {
    $db->rollBack();
    echo json_encode(["status" => false, "message" => "Error: " . $e->getMessage()]);
}
