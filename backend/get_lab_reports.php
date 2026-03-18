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

$input = json_decode(file_get_contents("php://input"), true);
$p_id = isset($input['p_id']) ? intval($input['p_id']) : null;
$r_id = isset($input['r_id']) ? intval($input['r_id']) : null;

$response = [];
$baseUrl = "https://jimble.traitsolutions.in/Restapi/patient/";

if ($p_id) {
    $query = "SELECT * FROM patient_scan_files WHERE p_id = :p_id AND file_path LIKE '%lab%'";

    // Apply r_id filter properly
    if ($r_id !== null) {
        $query .= " AND r_id = :r_id";
    } else {
        $query .= " AND (r_id IS NULL OR r_id = 0)";
    }

    $query .= " ORDER BY id ASC";

    $stmt = $db->prepare($query);
    $stmt->bindParam(':p_id', $p_id, PDO::PARAM_INT);

    if ($r_id !== null) {
        $stmt->bindParam(':r_id', $r_id, PDO::PARAM_INT);
    }

    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($results) {
        $grouped = [];

        foreach ($results as $row) {
            $key = $row['file_path'] . '|' . $row['type'];

            if (!isset($grouped[$key])) {
                $grouped[$key] = [
                    'folder_name' => $row['file_path'],
                    'files' => [[
                        'id' => $row['id'],
                        'sno' => 1,
                        'report_id' => $row['report_id'],
                        'p_id' => $row['p_id'],
                        'r_id' => $row['r_id'],
                        'p_date' => $row['p_date'],
                        'type' => $row['type'],
                        'file_name' => $row['file_name'],
                        'file_url' => []
                    ]]
                ];
            }

            $fileUrl = $baseUrl . $row['file_path'] . $row['file_name'];
            $grouped[$key]['files'][0]['file_url'][] = $fileUrl;
        }

        $response = ['status' => true, 'data' => array_values($grouped)];
    } else {
        $response = ['status' => false, 'message' => 'No lab files found for the given p_id' . ($r_id !== null ? ' and r_id.' : '.')];
    }
} else {
    $response = ['status' => false, 'message' => 'p_id is required.'];
}

echo json_encode($response, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
