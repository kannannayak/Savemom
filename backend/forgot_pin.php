<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include './config/database.php';

$database = new Database();
$conn = $database->getConnection();

// Read JSON raw data
$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo json_encode(["status" => false, "message" => "Only POST method allowed."]);
    exit;
}

$action = $data['action'] ?? '';
error_log("Action received: " . $action);

// Function to send OTP via SMS with patient name
function sendSMS($mobile, $otp, $user_name = '') {
    if (is_array($mobile)) {
        $mobile = reset($mobile);
    }

    $uid    = "jimble";                        
    $pwd    = "9435";                          
    $Peid   = "1601251174963010522"; // Entity ID
    $tempid = "1607100000000357961"; // Template ID
    $sender = "JIMBLE";                        

    // Ensure mobile starts with 91
    if (preg_match('/^[0-9]{10}$/', $mobile)) {
        $mobile = "91" . $mobile; 
    }

    if (!preg_match('/^91[0-9]{10}$/', $mobile)) {
        return "Invalid mobile number format. Use 91XXXXXXXXXX";
    }

    $message = "Dear {$user_name}, Please use OTP {$otp} to authenticate password change -JIMBLE";

    $post_fields = http_build_query([
        "uid"      => $uid,
        "pwd"      => $pwd,
        "mobile"   => $mobile,
        "sid"      => $sender,
        "entityid" => $Peid,
        "tempid"   => $tempid,
        "msg"      => $message,  
        "var1"     => $otp       
    ]);

    $api_url = "http://smsintegra.com/api/smsapi.aspx";

    $ch = curl_init($api_url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_fields);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);

    $response = curl_exec($ch);

    if (curl_errno($ch)) {
        $error = curl_error($ch);
        curl_close($ch);
        return "cURL Error: " . $error;
    }

    curl_close($ch);
    return $response;
}

// Request OTP
if ($action === 'request_otp') {
    $mobile = htmlspecialchars(strip_tags($data['mobile'] ?? ''));

    // Get patient name from patient table
    $stmt = $conn->prepare("SELECT p_name FROM patient WHERE mobile_no = :mobile LIMIT 1");
    $stmt->execute([':mobile' => $mobile]);

    if ($stmt->rowCount() === 0) {
        echo json_encode(["status" => false, "message" => "Invalid mobile number."]);
        exit;
    }

    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    $user_name = $row['p_name'];

    $otp = rand(1000, 9999);
    $otpExpiry = date('Y-m-d H:i:s', time() + 600); // 10 minutes

    // Store OTP in database
    $stmt = $conn->prepare("UPDATE patient SET otp = :otp, otp_generated_at = :otp_generated_at WHERE mobile_no = :mobile");
    $stmt->execute([':otp' => $otp, ':otp_generated_at' => $otpExpiry, ':mobile' => $mobile]);

    // Send OTP via SMS
    $smsResponse = sendSMS($mobile, $otp, $user_name);

    if (strpos(strtolower($smsResponse), 'error') !== false) {
        echo json_encode(["status" => false, "message" => "Failed to send OTP via SMS: " . $smsResponse]);
    } else {
        echo json_encode(["status" => true, "message" => "OTP sent successfully via SMS."]);
    }

// Verify OTP
} elseif ($action === 'verify_otp') {
    $mobile = htmlspecialchars(strip_tags($data['mobile'] ?? ''));
    $otp = htmlspecialchars(strip_tags($data['otp'] ?? ''));

    $stmt = $conn->prepare("SELECT otp, otp_generated_at FROM patient WHERE mobile_no = :mobile LIMIT 1");
    $stmt->execute([':mobile' => $mobile]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        echo json_encode(["status" => false, "message" => "Invalid mobile number."]);
        exit;
    }

    if ($row['otp'] !== $otp || strtotime($row['otp_generated_at']) < time()) {
        echo json_encode(["status" => false, "message" => "Invalid or expired OTP."]);
        exit;
    }

    echo json_encode(["status" => true, "message" => "OTP verified. You can reset your password."]);

// Reset Password
} elseif ($action === 'reset_password') {
    $mobile = htmlspecialchars(strip_tags($data['mobile'] ?? ''));
    $new_password = htmlspecialchars(strip_tags($data['new_password'] ?? ''));
    $confirm_password = htmlspecialchars(strip_tags($data['confirm_password'] ?? ''));

    if (strlen($new_password) < 4) {
        echo json_encode(["status" => false, "message" => "Password must be at least 4 characters."]);
        exit;
    }

    if ($new_password !== $confirm_password) {
        echo json_encode(["status" => false, "message" => "Passwords do not match."]);
        exit;
    }

    $stmt = $conn->prepare("UPDATE patient SET pass = :pass, confirm_pss = :pass WHERE mobile_no = :mobile");
    $stmt->execute([
        ':pass' => $new_password, 
        ':mobile' => $mobile
    ]);

    echo json_encode(["status" => true, "message" => "Password reset successful."]);

} else {
    echo json_encode(["status" => false, "message" => "Invalid action."]);
}
?>
