<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Include database and validation files
include './config/database.php';
include './object/validate.php';

// Ensure only POST requests are allowed
if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo json_encode(["status" => false, "message" => "Only POST requests are allowed."]);
    exit;
}

// Read JSON input
$input = file_get_contents("php://input");
$data = json_decode($input, true);

// Validate JSON body
if (!$data) {
    echo json_encode(["status" => false, "message" => "Invalid or empty JSON body."]);
    exit;
}

// Check for API key
if (empty($data['api_key'])) {
    echo json_encode(["status" => false, "message" => "API Key is missing."]);
    exit;
}

// Get filters
$p_id = isset($data['p_id']) ? intval($data['p_id']) : null;
$p_jimble_id = isset($data['p_jimble_id']) ? trim($data['p_jimble_id']) : null;

// Ensure at least one identifier is provided
if ($p_id === null && empty($p_jimble_id)) {
    echo json_encode(["status" => false, "message" => "p_id or p_jimble_id is required."]);
    exit;
}

try {
    // Create DB connection
    $database = new Database();
    $conn = $database->getConnection();

    // Prepare SQL
    $sql = "SELECT p.p_id, p.p_name,p.p_jimble_id, pr.r_id,pr.r_jimble_id, pr.familymembername, pr.profile_img
            FROM patient AS p
            LEFT JOIN patient_relationships AS pr ON p.p_id = pr.p_id AND pr.delete_status = 0";

    $params = [];
    if ($p_id !== null) {
        $sql .= " WHERE p.p_id = ?";
        $params[] = $p_id;
    } else {
        $sql .= " WHERE p.p_jimble_id = ?";
        $params[] = $p_jimble_id;
    }

    // Execute query
    $stmt = $conn->prepare($sql);
    $stmt->execute($params);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($result && count($result) > 0) {
        $hasRelationships = array_filter($result, fn($row) => !empty($row['familymembername']));

        if ($hasRelationships) {
            echo json_encode([
                "status" => true,
                "message" => "Relationships fetched successfully.",
                "data" => $result
            ]);
        } else {
            // No relationships, return only patient info
            echo json_encode([
                "status" => true,
                "message" => "No relationships found, returning patient info only.",
                "data" => [[
                    "p_id" => $result[0]['p_id'],
                    "p_name" => $result[0]['p_name']
                ]]
            ]);
        }
    } else {
        echo json_encode([
            "status" => false,
            "message" => "No patient found for the given p_id or p_jimble_id."
        ]);
    }

} catch (PDOException $e) {
    echo json_encode([
        "status" => false,
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
