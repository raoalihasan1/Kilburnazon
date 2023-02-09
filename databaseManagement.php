<?php

session_start();

// Class To Instantiate An Object Of The Database To Query To
class Database
{

    private $dbHost;
    private $dbUsername;
    private $dbPassword;
    private $dbName;
    private $dbConnection;

    function __construct(
        $Host,
        $Username,
        $Password,
        $Database
    ) {
        $this->dbHost = $Host;
        $this->dbUsername = $Username;
        $this->dbPassword = $Password;
        $this->dbName = $Database;
    }

    function dbConnect()
    {
        $this->dbConnection =
            new mysqli($this->dbHost, $this->dbUsername, $this->dbPassword, $this->dbName);

        if ($this->dbConnection->connect_errno) return FALSE;

        return TRUE;
    }

    function dbDisconnect()
    {
        if ($this->dbConnect()) return $this->dbConnection->close();
    }

    function getDBHost()
    {
        return $this->dbHost;
    }

    function getDBUsername()
    {
        return $this->dbUsername;
    }

    function getDBPassword()
    {
        return $this->dbPassword;
    }

    function getDBName()
    {
        return $this->dbName;
    }

    function getDBConnection()
    {
        return $this->dbConnection;
    }

    function setDBHost(
        $Host
    ) {
        $this->dbHost = $Host;
    }

    function setDBUsername(
        $Username
    ) {
        $this->dbUsername = $Username;
    }

    function setDBPassword(
        $Password
    ) {
        $this->dbPassword = $Password;
    }

    function setDBName(
        $Database
    ) {
        $this->dbName = $Database;
    }

    // Function That Takes Parameters To Auto-Generate A Select Query To Run On The Database
    // Return The Primary Key of The Inserted Row Else Return -1 On Failure To Connect To The Database Or Insertion Failure
    function insertQuery(
        $Table,
        $Parameters,
        $Values
    ) {
        $Query = "INSERT INTO " . $Table . " " . $Parameters . " VALUES " . $Values;
        if ($this->dbConnect()) {
            if ($this->dbConnection->query($Query) === TRUE) return $this->dbConnection->insert_id;
        }

        return -1;
    }

    // Function That Takes Parameters To Auto-Generate A Select Query To Run On The Database
    // Return FALSE If The Result Is An Empty Array Else Return TRUE Or An Associative Array Containing The Search Result Data
    function selectQuery(
        $Attributes = "*",
        $Table,
        $Constraints = "",
        $Condition = "1",
        $Additional = "",
        $CheckRecordExists = FALSE
    ) {
        $Query = "SELECT " . $Attributes . " FROM " . $Table . " " . $Constraints . " WHERE " . $Condition . " " . $Additional;
        if ($this->dbConnect())  $queryDB = $this->dbConnection->query($Query);
        else return FALSE;

        if ($queryDB && $queryDB->num_rows > 0) {
            if ($CheckRecordExists) {
                return TRUE;
            } else {
                return $queryDB->fetch_all(MYSQLI_ASSOC);
            }
        }
        return FALSE;
    }

    // Function That Takes Parameters To Auto-Generate An Update Query To Run On The Database
    // Return FALSE If The Update Failed Or Couldn't Connect To The Database Else Return TRUE If The Update Was Successful
    function updateQuery(
        $Table,
        $valuesToUpdate,
        $Condition
    ) {
        $Query = "UPDATE " . $Table . " SET " . $valuesToUpdate . "  WHERE " . $Condition;
        if ($this->dbConnect()) return $this->dbConnection->query($Query);
        return FALSE;
    }

    // Function That Takes Parameters To Auto-Generate A Delete Query To Run On The Database
    // Return FALSE If The Delete Failed Or Couldn't Connect To The Database Else Return TRUE If The Delete Was Successful
    function deleteQuery(
        $Table,
        $Condition
    ) {
        $Query = "DELETE FROM " . $Table . " WHERE " . $Condition;
        if ($this->dbConnect()) return $this->dbConnection->query($Query);
        return FALSE;
    }

    function getProcedures()
    {
        $Query = "SELECT routine_name FROM information_schema.routines WHERE routine_schema = '$this->dbName'";
        if ($this->dbConnect()) return $this->dbConnection->query($Query)->fetch_all(MYSQLI_ASSOC);
        return FALSE;
    }

    // Function That Returns An Associative Array Of The Procdeure Passed As An Argument Or FALSE If Database Connection Failed Or Procedure Returned An Empty Array
    function callProcedure(
        $procedureNameAndParameters
    ) {
        $Query = "CALL $procedureNameAndParameters";
        if ($this->dbConnect()) {
            $getProcedureResults = $this->dbConnection->query($Query);
            if ($getProcedureResults && $getProcedureResults->num_rows > 0) return $getProcedureResults->fetch_all(MYSQLI_ASSOC);
            return FALSE;
        }
        return FALSE;
    }
}
