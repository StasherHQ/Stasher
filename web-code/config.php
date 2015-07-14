<?php	
$servername = "localhost";
$username = "root";
$password = "bandit@Pride1";
$dbname = "db_stasher";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

?>
