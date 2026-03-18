<?php 
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include './config/database.php';  // Include database configuration
include './object/validate.php';  // Include API key validation class

// Get the raw POST body
$data = json_decode(file_get_contents("php://input"), true);

// Validate request method and JSON
if ($_SERVER["REQUEST_METHOD"] !== "POST" || !$data) {
    echo json_encode(["status" => false, "message" => "Invalid request."]);
    exit;
}

// Validate API key
if (!isset($data['api_key']) || empty($data['api_key'])) {
    echo json_encode(["status" => false, "message" => "API Key is missing."]);
    exit;
}

// Create database connection and validator object
$database = new Database();
$conn = $database->getConnection();
$validate = new Validate($conn);

// Extract credentials from JSON
$mobile_no = $data['mobile_no'] ?? '';
$pass = $data['pass'] ?? '';
$language = $data['language'] ?? 'english'; // default to 'english'

// Check for missing credentials
if (empty($mobile_no) || empty($pass)) {
    echo json_encode(["status" => false, "message" => "Missing credentials."]);
    exit;
}

// Query the patient table using PDO
$stmt = $conn->prepare("SELECT * FROM patient WHERE mobile_no = :mobile_no AND delete_status = 0 AND active_status = 0 LIMIT 1");
$stmt->bindParam(':mobile_no', $mobile_no);
$stmt->execute();
$user = $stmt->fetch(PDO::FETCH_ASSOC);

// Check if user exists
if ($user) {
    // Compare the input password with the stored password
    if ($pass === $user['pass']) {
        // ✅ Save preferred language
        $update = $conn->prepare("UPDATE patient SET preferred_language = :language WHERE mobile_no = :mobile_no");
        $update->bindParam(':language', $language);
        $update->bindParam(':mobile_no', $mobile_no);
        $update->execute();

        // Return updated user data
        $user['preferred_language'] = $language;

        echo json_encode([
            "status" => true,
            "message" => "Login successful. Language updated.",
            "data" => $user
        ]);
    } else {
        // Incorrect password
        echo json_encode(["status" => false, "message" => "Incorrect password."]);
    }
} else {
    // User not found
    echo json_encode(["status" => false, "message" => "User not found."]);
}

?>
