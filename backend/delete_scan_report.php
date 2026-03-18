<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

include_once 'config/database.php';

$database = new Database();
$db = $database->getConnection();

// Get JSON input
$input = json_decode(file_get_contents("php://input"), true);

$p_id = isset($input['p_id']) ? intval($input['p_id']) : null;
// Treat empty string as null
$r_id = isset($input['r_id']) && $input['r_id'] !== '' ? intval($input['r_id']) : null;
$folder_name = isset($input['folder_name']) ? trim($input['folder_name']) : '';

// Validate required parameters
if (!$p_id || empty($folder_name)) {
    echo json_encode(["status" => false, "message" => "p_id and folder_name are required."]);
    exit;
}

// Optional: Validate r_id belongs to p_id
if ($r_id !== null) {
    $checkStmt = $db->prepare("SELECT COUNT(*) FROM patient_relationships WHERE p_id = ? AND r_id = ?");
    $checkStmt->execute([$p_id, $r_id]);
    if (!$checkStmt->fetchColumn()) {
        echo json_encode(["status" => false, "message" => "Relation does not belong to the patient."]);
        exit;
    }
}

// Delete files from folder
$folderPath = __DIR__ . '/' . $folder_name;

if (is_dir($folderPath)) {
    $files = glob($folderPath . '/*');
    foreach ($files as $file) {
        if (is_file($file)) {
            unlink($file);
        }
    }
    rmdir($folderPath); // Delete folder itself
} elseif (is_file($folderPath)) {
    // If folder_name is a single file
    unlink($folderPath);
}

// Delete entries from DB
if ($r_id === null) {
    $stmt = $db->prepare("DELETE FROM patient_scan_files WHERE p_id = ? AND (r_id IS NULL OR r_id = 0) AND file_path = ?");
    $stmt->execute([$p_id, $folder_name]);
} else {
    $stmt = $db->prepare("DELETE FROM patient_scan_files WHERE p_id = ? AND r_id = ? AND file_path = ?");
    $stmt->execute([$p_id, $r_id, $folder_name]);
}

echo json_encode([
    "status" => true,
    "message" => "All files in the folder have been deleted successfully."
]);
