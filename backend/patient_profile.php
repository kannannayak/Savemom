<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include './config/database.php';

$database = new Database();
$conn = $database->getConnection();

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents("php://input"), true);
    error_log(print_r($input, true));  // Debugging

    $p_id = $input['p_id'] ?? '';
    $r_id = $input['r_id'] ?? ''; // optional

    if (empty($p_id)) {
        echo json_encode(["status" => false, "message" => "Missing p_id."]);
        exit;
    }

    try {
        // When only p_id is sent, return patient + all relationships
        if (empty($r_id)) {
            // Get patient details
            $stmt = $conn->prepare("SELECT * FROM patient WHERE p_id = ? AND delete_status = 0");
            $stmt->execute([$p_id]);
            $patient = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$patient) {
                echo json_encode(["status" => false, "message" => "Patient not found."]);
                exit;
            }

            // Get all relationships
            $stmt_rel = $conn->prepare("SELECT * FROM patient_relationships WHERE p_id = ? AND delete_status = 0");
            $stmt_rel->execute([$p_id]);
            $relationships = $stmt_rel->fetchAll(PDO::FETCH_ASSOC);

            echo json_encode([
                "status" => true,
                "message" => "Patient profile with relationships fetched successfully.",
                "data" => [
                    "patient" => $patient,
                    "relationships" => $relationships
                ]
            ]);
        } else {
            // Only fetch the specific relationship if both p_id and r_id are present
            $stmt = $conn->prepare("SELECT * FROM patient_relationships WHERE p_id = ? AND r_id = ? AND delete_status = 0");
            $stmt->execute([$p_id, $r_id]);
            $relationship = $stmt->fetch(PDO::FETCH_ASSOC);

            echo json_encode([
                "status" => true,
                "message" => $relationship ? "Relationship fetched successfully." : "Relationship not found.",
                "data" => [
                    "relationship" => $relationship ?: null
                ]
            ]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => false, "message" => "Error: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["status" => false, "message" => "Only POST method allowed."]);
}
