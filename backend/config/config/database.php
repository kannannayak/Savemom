<?php
// used to get mysql database connection
class Database {
    private $host = "localhost";

   
    private $db_name = "u194236851_jimble";
    private $username = "u194236851_jimble";
    private $password = "U194236851_jimble";
 
 
    public $conn;

    public function getConnection(){
        $this->conn = null;
        try{
            $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
            $this->conn->exec("set names utf8");
        } catch(PDOException $exception){
            echo "Connection error: " . $exception->getMessage();
        }
        return $this->conn;
    }
}

?>