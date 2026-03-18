<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include './config/database.php';
include './object/validate.php';
require './PHPMailer/src/PHPMailer.php';
require './PHPMailer/src/SMTP.php';
require './PHPMailer/src/Exception.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$database = new Database();
$conn = $database->getConnection();
$validate = new Validate($conn);

function uploadImage($file, $folder = "uploads/") {
    if (!isset($file) || $file['error'] !== UPLOAD_ERR_OK) return null;
    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    $allowed = ['jpg', 'jpeg', 'png', 'gif'];
    if (!in_array($ext, $allowed)) return null;
    if (!file_exists($folder)) mkdir($folder, 0777, true);
    $fileName = uniqid() . "." . $ext;
    $uploadPath = $folder . $fileName;
    return move_uploaded_file($file['tmp_name'], $uploadPath) ? $uploadPath : null;
}

function generateJimbleId($conn, $type = 'patient') {
    $prefix = $type === 'patient' ? 'JTN2500' : 'JTNA2500';
    $column = $type === 'patient' ? 'p_jimble_id' : 'r_jimble_id';
    $table  = $type === 'patient' ? 'patient' : 'patient_relationships';
    $stmt = $conn->prepare("SELECT $column FROM $table WHERE $column LIKE :prefix ORDER BY $column DESC LIMIT 1");
    $stmt->execute([':prefix' => $prefix . '%']);
    $lastId = $stmt->fetchColumn();
    $newNum = $lastId ? ((int)substr($lastId, strlen($prefix)) + 1) : 1;
    return $prefix . str_pad($newNum, 2, '0', STR_PAD_LEFT);
}


function getAlphabeticSuffix($index) {
    $letters = '';
    while ($index >= 0) {
        $letters = chr(65 + ($index % 26)) . $letters;
        $index = floor($index / 26) - 1;
    }
    return $letters;
}

function sendSMS($mobile, $otp) {
    if (is_array($mobile)) {
        $mobile = reset($mobile);
    }

    $uid    = "jimble";                        
    $pwd    = "9435";                          
    $Peid   = "1601251174963010522"; // Entity ID
    $tempid = "1607100000000357958"; // Template ID
    $sender = "JIMBLE";                        

    // Ensure mobile starts with 91
    if (preg_match('/^[0-9]{10}$/', $mobile)) {
        $mobile = "91" . $mobile;
    }
    if (!preg_match('/^91[0-9]{10}$/', $mobile)) {
        return "Invalid mobile number format. Use 91XXXXXXXXXX";
    }

    // Message must match DLT template
    $message = "Thank you for choosing JIMBLE. Your OTP for registration is $otp and is valid for 10 minutes -JIMBLE";

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


if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo json_encode(["status" => false, "message" => "Only POST method allowed."]);
    exit;
}

$inputData = $_POST;
if (empty($inputData) && !empty(file_get_contents('php://input'))) {
    $inputData = json_decode(file_get_contents('php://input'), true);
}

if (empty($inputData['api_key'])) {
    echo json_encode(["status" => false, "message" => "API Key is missing."]);
    exit;
}
$validate->api_key = htmlspecialchars(strip_tags($inputData['api_key']));
if (!$validate->getValidate()->rowCount()) {
    echo json_encode(["status" => false, "message" => "Invalid API Key."]);
    exit;
}

// ✅ Verify OTP
if (isset($inputData['verify_otp']) && $inputData['verify_otp'] === true) {
    $p_id = $inputData['p_id'] ?? null;
    $otp = $inputData['otp'] ?? null;

    if (empty($p_id) || empty($otp)) {
        echo json_encode(["status" => false, "message" => "Patient ID and OTP are required."]);
        exit;
    }

    $stmt = $conn->prepare("SELECT * FROM patient WHERE p_id = :p_id AND otp = :otp AND otp_generated_at >= NOW() - INTERVAL 5 MINUTE");
    $stmt->execute([':p_id' => $p_id, ':otp' => $otp]);

    if ($stmt->rowCount() === 0) {
        echo json_encode(["status" => false, "message" => "Invalid or expired OTP."]);
        exit;
    }

  $conn->prepare("UPDATE patient SET status = 'active' WHERE p_id = :p_id")
     ->execute([':p_id' => $p_id]);

$stmt = $conn->prepare("SELECT emil, p_name, p_jimble_id FROM patient WHERE p_id = :p_id");
$stmt->execute([':p_id' => $p_id]);
$patient = $stmt->fetch(PDO::FETCH_ASSOC);

if ($patient) {
    // Send confirmation email
    try {
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'jimble.otp@gmail.com';
        $mail->Password   = 'ospi qknv ziaj hxiy';
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;

        $mail->setFrom('jimble.otp@gmail.com', 'Jimble App');
        $mail->addAddress($patient['emil'], $patient['p_name']);

        $mail->isHTML(true);
        $mail->Subject = 'Registration Confirmed – Jimble App';
        $mail->Body    = "
            <p>Hello Mr/Ms. <strong>{$patient['p_name']}</strong>, </p>
            <p> Welcome to Jimble! Your patient ID <strong>{$patient['p_jimble_id']}</strong> has been created successfully. You can now upload your reports,fix appointments and connect with your trusted specialist from anywhere to everywhere in India.:</p>
       
            <p>Thank you for registering with Jimble App!</p>
        ";

        $mail->send();
    } catch (Exception $e) {
        // Log or handle email failure if needed
    }

    echo json_encode([
        "status" => true,
        "message" => "OTP verified and confirmation email sent successfully.",
        "jimble_id" => $patient['p_jimble_id']
    ]);
    exit;
} else {
    echo json_encode(["status" => false, "message" => "Patient not found after OTP verification."]);
    exit;
}

}

// ✅ Resend OTP
if (isset($inputData['resend_otp']) && $inputData['resend_otp'] === true) {
    $p_id = $inputData['p_id'] ?? null;

    if (empty($p_id)) {
        echo json_encode(["status" => false, "message" => "Patient ID is required to resend OTP."]);
        exit;
    }

    $stmt = $conn->prepare("SELECT emil FROM patient WHERE p_id = :p_id");
    $stmt->execute([':p_id' => $p_id]);
    $patient = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$patient) {
        echo json_encode(["status" => false, "message" => "Invalid patient ID."]);
        exit;
    }

    $otp = rand(1000, 9999);
    $conn->prepare("UPDATE patient SET otp = :otp, otp_generated_at = NOW() WHERE p_id = :p_id")
         ->execute([':otp' => $otp, ':p_id' => $p_id]);

    try {
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'jimble.otp@gmail.com';
        $mail->Password   = 'ospi qknv ziaj hxiy';
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;
        $mail->setFrom('jimble.otp@gmail.com', 'Jimble App');
        $mail->addAddress($patient['emil']);
        $mail->isHTML(true);
        $mail->Subject = 'Your OTP Code (Resent)';
        $mail->Body    = "Your new OTP code is: <strong>{$otp}</strong>. It is valid for 5 minutes.";
        $mail->send();

        echo json_encode(["status" => true, "message" => "OTP resent successfully."]);
        exit;
    } catch (Exception $e) {
        echo json_encode(["status" => false, "message" => "Failed to send OTP email."]);
        exit;
    }
}

// ✅ Registration Flow
$patient_data = [];
$fields = [
    'mrms', 'p_name', 'mobile_no', 'emil', 'dob', 'age', 'gender',
    'aadhar_no', 'address', 'location', 'pincode', 'city', 'district', 'state',
    'pass', 'confirm_pss'
];
foreach ($fields as $f) {
    $patient_data[$f] = htmlspecialchars(strip_tags($inputData[$f] ?? ''));
}

if ($patient_data['pass'] !== $patient_data['confirm_pss']) {
    echo json_encode(["status" => false, "message" => "Passwords do not match."]);
    exit;
}
unset($patient_data['confirm_pss']);

$patient_data['pass'] = $patient_data['pass'];
$patient_profile = isset($_FILES['patient_profile']) ? uploadImage($_FILES['patient_profile']) : null;


try {
    $conn->beginTransaction();

    // Check if pending patient exists
    $stmt = $conn->prepare("SELECT p_id, p_jimble_id FROM patient WHERE (emil = :emil OR mobile_no = :mobile_no) AND status = 'pending' LIMIT 1");
    $stmt->execute([':emil' => $patient_data['emil'], ':mobile_no' => $patient_data['mobile_no']]);
    $existing = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($existing) {
        $p_id = $existing['p_id'];
        $patient_jimble_id = $existing['p_jimble_id'];

        $stmt = $conn->prepare("UPDATE patient SET 
            patient_profile = :patient_profile, mrms = :mrms, p_name = :p_name, 
            dob = :dob, age = :age, gender = :gender, aadhar_no = :aadhar_no, 
            address = :address, location = :location, pincode = :pincode, 
            city = :city, district = :district, state = :state, pass = :pass 
            WHERE p_id = :p_id");

        foreach ($patient_data as $key => $val) {
            if ($key !== 'mobile_no' && $key !== 'emil') {
                $stmt->bindValue(':' . $key, $val);
            }
        }
        $stmt->bindValue(':p_id', $p_id);
        $stmt->bindValue(':patient_profile', $patient_profile);
        $stmt->execute();
    } else {
        $check = $conn->prepare("SELECT p_id FROM patient WHERE emil = :emil OR mobile_no = :mobile_no AND status = 'active'");
        $check->execute([':emil' => $patient_data['emil'], ':mobile_no' => $patient_data['mobile_no']]);
        if ($check->rowCount() > 0) throw new Exception("Email or mobile already registered.");

        $patient_data['p_jimble_id'] = generateJimbleId($conn, 'patient');
        $patient_jimble_id = $patient_data['p_jimble_id'];

        $sql = "INSERT INTO patient
            (p_jimble_id, patient_profile, mrms, p_name, mobile_no, emil, dob, age, gender,
             aadhar_no, address, location, pincode, city, district, state, pass, status)
            VALUES
            (:p_jimble_id, :patient_profile, :mrms, :p_name, :mobile_no, :emil, :dob, :age, :gender,
             :aadhar_no, :address, :location, :pincode, :city, :district, :state, :pass, 'pending')";
        $stmt = $conn->prepare($sql);
        foreach ($patient_data as $key => $val) {
            $stmt->bindValue(':' . $key, $val);
        }
        $stmt->bindValue(':patient_profile', $patient_profile);
        $stmt->execute();
        $p_id = $conn->lastInsertId();
    }

    if (!empty($inputData['relationships'])) {
        $rels = is_string($inputData['relationships']) ? json_decode($inputData['relationships'], true) : $inputData['relationships'];
        if (is_array($rels)) {
            $existingRelStmt = $conn->prepare("SELECT COUNT(*) FROM patient_relationships WHERE p_id = :p_id");
            $existingRelStmt->execute([':p_id' => $p_id]);
            $existingRelCount = $existingRelStmt->fetchColumn();
    
            if ($existingRelCount == 0) {
                $stmt_rel = $conn->prepare("INSERT INTO patient_relationships
                    (p_id, r_jimble_id, mrms, relationship, familymembername, dob, age, gender, aadhar_no, profile_img)
                    VALUES
                    (:p_id, :r_jimble_id, :mrms, :relationship, :familymembername, :dob, :age, :gender, :aadhar_no, :profile_img)");
    
                foreach ($rels as $i => $rel) {
                    $alphabetSuffix = getAlphabeticSuffix($i); // 0 -> A, 1 -> B, 26 -> AA
                    $r_jimble_id = $patient_jimble_id . $alphabetSuffix;
                    $imgPath = isset($_FILES["profile_img_$i"]) ? uploadImage($_FILES["profile_img_$i"]) : null;
    
                    $stmt_rel->execute([
                        ':p_id' => $p_id,
                        ':r_jimble_id' => $r_jimble_id,
                        ':mrms' => $rel['mrms'] ?? '',
                        ':relationship' => $rel['relationship'] ?? null,
                        ':familymembername' => $rel['familymembername'] ?? null,
                        ':dob' => $rel['dob'] ?? null,
                        ':age' => $rel['age'] ?? null,
                        ':gender' => $rel['gender'] ?? null,
                        ':aadhar_no' => $rel['aadhar_no'] ?? null,
                        ':profile_img' => $imgPath
                    ]);
                }
            }
        }
    }
    // Send OTP for registration
    $otp = rand(1000, 9999);
    $conn->prepare("UPDATE patient SET otp = :otp, otp_generated_at = NOW() WHERE p_id = :p_id")
        ->execute([':otp' => $otp, ':p_id' => $p_id]);

    $mail = new PHPMailer(true);
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'jimble.otp@gmail.com';
    $mail->Password   = 'ospi qknv ziaj hxiy';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;
    $mail->setFrom('jimble.otp@gmail.com', 'Jimble App');
    $mail->addAddress($patient_data['emil']);
    $mail->isHTML(true);
    $mail->Subject = 'Your OTP Code';
    $mail->Body    = "Your OTP code is: <strong>{$otp}</strong>. It is valid for 5 minutes.";
    $mail->send();




// Send OTP to mobile
$smsResponse = sendSMS($patient_data['mobile_no'], $otp);

$conn->commit();

echo json_encode([
    "status" => true,
    "message" => "OTP sent to email and SMS.",
    "p_id" => $p_id,
    "next_step" => "Call /api with verify_otp=true&p_id=$p_id&otp=XXXX",
    "sms_response" => $smsResponse
]);

} catch (Exception $e) {
    if ($conn->inTransaction()) $conn->rollBack();
    echo json_encode([
        "status" => false,
        "message" => "Error: " . $e->getMessage()
    ]);
}