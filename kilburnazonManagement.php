<?php

session_start();
include_once "databaseManagement.php";
include_once "loggedInEmployee.php";

$KilburnazonDB;
$loggedInEmployee;

isset($_SESSION['dbConnection']) ? $KilburnazonDB = unserialize($_SESSION['dbConnection']) : NULL;
isset($_SESSION['loggedInEmployee']) ? $loggedInEmployee = unserialize($_SESSION['loggedInEmployee']) : NULL;
isset($_POST['editBtn']) ? (($_SESSION['encryptedEmployeeNum'] = $_POST['editBtn']) . (header("Location: updateEmployee.php"))) : NULL;
isset($_POST['deleteBtn']) ? deleteEmployee($_POST['deleteBtn']) : NULL;
isset($_POST['logOut']) ? (logOut() ? header("Location: logIn.php") : NULL) : NULL;

// Function To Sanitize Input Before Inserting Into The Database
function cleanInput(
    $Input
) {
    return stripslashes(trim(htmlspecialchars($Input)));
}

// Function Called When Employee Logs Into Their Account
function logInForm(
    $employeeNum,
    $NIN
) {
    global $KilburnazonDB, $loggedInEmployee;
    $logInErrors = array();

    if (substr($employeeNum, 2, 1) != "-")
        $employeeNum = substr($employeeNum, 0, 2) . "-" . substr($employeeNum, 2, strlen($employeeNum));

    $KilburnazonDB = new Database('localhost', 'root', '', 'Kilburnazon');

    if (!$KilburnazonDB->dbConnect()) {
        array_push($logInErrors, "Error: Failed To Connect To The Database");
        return $logInErrors;
    } else {
        if (!$KilburnazonDB->selectQuery(
            "*",
            "Employees",
            "",
            "Number = '$employeeNum' AND NIN = '$NIN'",
            "LIMIT 1",
            TRUE
        )) {
            array_push($logInErrors, "Incorrect Employee Number Or National Insurance Number");
            return $logInErrors;
        } else {
            $employeeDetails = $KilburnazonDB->selectQuery(
                "*",
                "Employees",
                "INNER JOIN Employee_Details ON Employee_Details.NIN = Employees.NIN",
                "Employees.Number = '$employeeNum' AND Employees.NIN = '$NIN'",
                "LIMIT 1"
            );
            $loggedInEmployee = new Employee(
                $employeeDetails[0]["Number"],
                $employeeDetails[0]["NIN"],
                $employeeDetails[0]["Department_Number"],
                $employeeDetails[0]["Manager_ID"],
                $employeeDetails[0]["First_Name"],
                $employeeDetails[0]["Last_Name"],
                $employeeDetails[0]["Street_Address"],
                $employeeDetails[0]["City"],
                $employeeDetails[0]["Postcode"],
                $employeeDetails[0]["DOB"],
                $employeeDetails[0]["Salary"]
            );
            $_SESSION['dbConnection'] = serialize($KilburnazonDB);
            $_SESSION['loggedInEmployee'] = serialize($loggedInEmployee);
            header("Location: searchKilburnazon.php");
            exit();
        }
    }
}

// Function Called To Destroy All Instantiated Objects And The Session When Logging Out
function logOut()
{
    global $KilburnazonDB;
    if ($KilburnazonDB->dbDisconnect()) {
        if (session_destroy()) {
            unset($KilburnazonDB, $loggedInEmployee);
            return TRUE;
        }
    }
    return FALSE;
}

// Function Called When Inserting A New Employee To Insert Data In Their Respective Tables In The Database
function addEmployeeForm(
    $empNumber,
    $fName,
    $lName,
    $streetAddress,
    $City,
    $postCode,
    $NIN,
    $DOB,
    $Salary,
    $ecFName,
    $ecLName,
    $Relationship,
    $ecPhoneNumber,
    $departmentName
) {
    global $KilburnazonDB;

    // Check That An Employee With The Number Or NIN Doesn't Already Exist
    $ninExists = $KilburnazonDB->selectQuery("NIN", "Employees", "", "NIN = '$NIN'", "LIMIT 1", TRUE);
    $empNumExists = $KilburnazonDB->selectQuery("Number", "Employees", "", "Number = '$empNumber'", "LIMIT 1", TRUE);

    if ($empNumExists) {
        $_SESSION["alreadyExistsNum"] = "An Employee With This Number Already Exists";
        return NULL;
    } else if ($ninExists) {
        $_SESSION["alreadyExistsNIN"] = "An Employee With This National Insurance Number Exists";
        return NULL;
    }

    try {
        // Create A Transaction When Inserting Into Multiple Tables
        $KilburnazonDB->getDBConnection()->begin_transaction();
        $KilburnazonDB->insertQuery(
            "Employee_Details",
            "(NIN, First_Name, Last_Name, Street_Address, City, Postcode, Salary, DOB)",
            "('$NIN', '$fName', '$lName', '$streetAddress', '$City', '$postCode', '$Salary', '$DOB')"
        );
        $KilburnazonDB->insertQuery(
            "Employees",
            "(Number, NIN, Department_Number, Manager_ID)",
            "('$empNumber', '$NIN', (SELECT Departments.Number FROM Departments WHERE Departments.Name = '$departmentName'), (SELECT Managers.ID FROM Managers ORDER BY RAND() LIMIT 1))"
        );
        // Determine Which Department The Employee Is In And Insert Into The Respective Table According To That
        switch ($departmentName) {
            case "Management":
            case "HR":
                $KilburnazonDB->insertQuery(
                    "$departmentName",
                    "(Employee_Number, Office_ID)",
                    "('$empNumber', (SELECT ID FROM Offices ORDER BY RAND() LIMIT 1))"
                );
                break;
            case "Packagers":
                $KilburnazonDB->insertQuery(
                    "Packagers",
                    "(Employee_Number)",
                    "('$empNumber')"
                );
                break;
            case "Drivers":
                $KilburnazonDB->insertQuery(
                    "Drivers",
                    "(Employee_Number, Hours_Per_Week)",
                    "('$empNumber', " . rand(12, 50) . ")"
                );
                break;
        }
        $KilburnazonDB->insertQuery(
            "Emergency_Contacts",
            "(First_Name, Last_Name, Relationship, Phone_Number, Employee_Number)",
            "('$ecFName', '$ecLName', '$Relationship', '$ecPhoneNumber', '$empNumber')"
        );
        $KilburnazonDB->updateQuery("Department_Details", "Employee_Count = (SELECT COUNT(ID) FROM $departmentName)", "Name = '$departmentName'");
        $KilburnazonDB->getDBConnection()->commit();
        $_SESSION["employeeInserted"] = TRUE;
        return TRUE;
    } catch (Exception $E) {
        // Rollback The State Of The Database If The Transaction Fails
        $KilburnazonDB->getDBConnection()->rollback();
        return FALSE;
    }
}

// Show All The Departments In Kilburnazon To Select One From When Adding A New Employee Or When Searching For An Employee
function displayDepartmentOptions(
    $selectedOption,
    $addEmployeeForm = TRUE
) {
    global $KilburnazonDB;
    $departmentNames = $KilburnazonDB->selectQuery(
        "Name",
        "Department_Details",
        "",
        "1"
    );
    foreach ($departmentNames as $Department) {
        if ($addEmployeeForm)
            if ($selectedOption != NULL && $Department['Name'] == $selectedOption)
                echo "<option value=" . $Department['Name'] . " selected>" . $Department['Name'] . "</option>";
            else echo "<option value=" . $Department['Name'] . ">" . $Department['Name'] . "</option>";
        else echo "<option value=" . $Department['Name'] . ">" . $Department['Name'] . "</option>";
    }
}

// Show All The UK Cities To Select One From When Adding A New Employee (Information ABout UK Cities Collected From https://www.gov.uk/government/publications/list-of-cities/list-of-cities-html)
function displayUKCities(
    $selectedOption
) {
    global $KilburnazonDB;
    $ukCities = $KilburnazonDB->selectQuery(
        "Name",
        "Area",
        "",
        "1"
    );
    foreach ($ukCities as $City) {
        if ($selectedOption != NULL && $City['Name'] == $selectedOption)
            echo "<option value=" . $City['Name'] . " selected>" . $City['Name'] . "</option>";
        else echo "<option value=" . $City['Name'] . ">" . $City['Name'] . "</option>";
    }
}

// Show All The Emergency Contact Relationships Of Existing Employees To Select From When Searching For An Employee Based On Relationship
function displayEmergencyContactRelationships()
{
    global $KilburnazonDB;
    $allRelationships = $KilburnazonDB->selectQuery(
        "DISTINCT Relationship",
        "Emergency_Contacts",
        "",
        "1"
    );
    foreach ($allRelationships as $Relationship) {
        $relationName = $Relationship['Relationship'];
        echo "<option value='$relationName'>$relationName</option>";
    }
}

// Show All Procedures In The Kilburnazon Database To Select From As A Search Query
function displayProcedures()
{
    global $KilburnazonDB;
    $dbProcedures = $KilburnazonDB->getProcedures();
    if ($dbProcedures != FALSE)
        foreach ($dbProcedures as $Procedure)
            echo "<option value=" . $Procedure['routine_name'] . ">" . join(" ", explode("_", $Procedure['routine_name'])) . "</option>";
}

// Show The Results Of A Selected Procedure
function showProcedure(
    $procedureToCall
) {
    global $KilburnazonDB;
    $procedureResults = $KilburnazonDB->callProcedure($procedureToCall);
    if ($procedureResults != FALSE) {
        echo "<div class=tableEmployees><table class=employeeDetails><tr><th>Employee Number</th><th>Employee Name</th><th>Department Name</th><th>Date Of Birth</th></tr>";
        foreach ($procedureResults as $Result) echo "<tr><td>" . $Result['Number'] . "</td><td>" . $Result['Full_Name'] . "</td><td>" . $Result['Name'] . "</td><td>" . $Result['DOB'] . "</td></td></tr>";
        echo "</table></div>";
    } else {
        echo "<div class=resultContainer style='background:#721C24;'><div id=emptyNotes>No Results Found <i class='fa fa-search' aria-hidden=true></i></div></div>";
    }
}

// Function Called To Display All The Results Of A Search Query
function searchResult(
    $empNumber,
    $firstName,
    $lastName,
    $departmentName,
    $relationshipToEmployee
) {
    global $KilburnazonDB;
    $Condition = "";
    foreach ($_POST as $Key => $Value) {
        $Value = cleanInput($Value);
        if (!empty($Value) && strlen($Value) > 0) {
            // Determine Which Field The Search Has Been Done On And Concatenate The Select Condition To The Query Accordingly
            switch ($Key) {
                case "empID":
                    $Condition .= "Employees.Number = '$empNumber' AND ";
                    break;
                case "employeeFName":
                    $Condition .= "Employee_Details.First_Name = '$firstName' AND ";
                    break;
                case "employeeLName":
                    $Condition .= "Employee_Details.Last_Name = '$lastName' AND ";
                    break;
                case "emergencyRelationships":
                    $Condition .= "Emergency_Contacts.Relationship = '$relationshipToEmployee' AND ";
                    break;
                case "employeeDepartment":
                    $Condition .= "Departments.Name = '$departmentName'";
                    break;
            }
        }
    }
    if (substr($Condition, -4, -1) == "AND") $Condition =  substr($Condition, 0, -5);
    $employeeDetailsQuery = $KilburnazonDB->selectQuery(
        "CONCAT(Employee_Details.First_Name, ' ', Employee_Details.Last_Name) AS Full_Name, Employees.NIN, Departments.Name AS Dept_Name, Emergency_Contacts.Relationship, Employees.Manager_ID",
        "Employee_Details",
        "INNER JOIN Employees ON Employees.NIN = Employee_Details.NIN INNER JOIN Departments ON Departments.Number = Employees.Department_Number INNER JOIN Emergency_Contacts ON Employees.Number = Emergency_Contacts.Employee_Number",
        "$Condition"
    );
    if ($employeeDetailsQuery != FALSE) {
        $encryptedKeys = array();
        echo "<div class=tableEmployees><table class=employeeDetails><tr><th>Employee Name</th><th>Department Name</th><th>Contact Relationship</th><th>Manager Name</th><th>Change</th><th>Remove</th></tr>";
        foreach ($employeeDetailsQuery as $employeeDetails) {
            $managerID = $employeeDetails["Manager_ID"];
            $managerQuery = $KilburnazonDB->selectQuery(
                "CONCAT(Employee_Details.First_Name, ' ', Employee_Details.Last_Name) AS Manager_Name",
                "Employee_Details",
                "INNER JOIN Employees ON Employees.NIN = Employee_Details.NIN INNER JOIN Management ON Employees.Number = Management.Employee_Number INNER JOIN Managers ON Managers.Management_ID = Management.ID",
                "Managers.ID = '$managerID'",
                "LIMIT 1"
            );
            if ($managerQuery != FALSE) {
                $encryptEmployeeNIN = encryptEmployeeNumber($employeeDetails['NIN']);
                array_push($encryptedKeys, $encryptEmployeeNIN);
                echo "<tr>
                        <td>" . $employeeDetails['Full_Name'] . "</td>
                        <td>" . $employeeDetails['Dept_Name'] . "</td>
                        <td>" . $employeeDetails['Relationship'] . "</td>
                        <td>" . $managerQuery[0]['Manager_Name'] . "</td>
                            <td><form method=post><button id=Edit value='$encryptEmployeeNIN[0]' name=editBtn type=submit>Edit</button></form></td>
                            <td><form method=post><button id=Delete value='$encryptEmployeeNIN[0]' name=deleteBtn type=submit>Delete</button></form></td>
                     </tr>";
            }
        }
        echo "</table></div>";
        if (!empty($encryptedKeys)) $_SESSION['encryptedKeys'] = $encryptedKeys;
    } else {
        echo "<div class=resultContainer style='background:#721C24;'><div id=emptyNotes>No Results Found <i class='fa fa-search' aria-hidden=true></i></div></div>";
    }
}

// Encrypt The Employee NIN Using OpenSSL To Hide It From The User When Rendered In HTML Value For Extra Secure Protection
function encryptEmployeeNumber(
    $empNumber
) {
    $encryptionKey = openssl_digest(php_uname(), 'MD5', TRUE);
    $encryptionIV = random_bytes(openssl_cipher_iv_length("BF-CBC"));
    $encryptedEmployeeNum = openssl_encrypt(
        $empNumber,
        'BF-CBC',
        $encryptionKey,
        0,
        $encryptionIV
    );
    return array($encryptedEmployeeNum, "BF-CBC", openssl_digest(php_uname(), 'MD5', TRUE), 0, $encryptionIV);
}

// Decrypt The Encrypted Employee NIN To Perform Queries Using It
function decryptEmployeeNumber(
    $employeeElementArray
) {
    return openssl_decrypt($employeeElementArray[0], $employeeElementArray[1], $employeeElementArray[2], $employeeElementArray[3], $employeeElementArray[4]);
}

// Function Called To Delete The Employee From The Database When Button Is Clicked
function deleteEmployee(
    $empNINToDelete
) {
    global $KilburnazonDB, $loggedInEmployee;
    if (isset($_SESSION['encryptedKeys'])) {
        foreach ($_SESSION['encryptedKeys'] as $encryptedDetails) {
            if ($encryptedDetails[0] == $empNINToDelete) {
                $decryptedEmpNIN = decryptEmployeeNumber($encryptedDetails);
                $empDetails = $KilburnazonDB->selectQuery("Employees.Number, Departments.Name", "Employees", "INNER JOIN Departments ON Departments.Number = Employees.Department_Number", "Employees.NIN = '$decryptedEmpNIN'");
                $empNum = $empDetails[0]['Number'];
                $empDept = $empDetails[0]['Name'];
                try {
                    // Create A Transaction When Deleting And Updating Multiple Tables
                    $KilburnazonDB->getDBConnection()->begin_transaction();
                    $KilburnazonDB->deleteQuery("Employee_Details", "NIN = '$decryptedEmpNIN'");
                    $KilburnazonDB->updateQuery("Auditing_Employees_Table", "Employee_Who_Deleted = '" . $loggedInEmployee->getEmployeeNumber() . "'", "Employee_Number_Deleted = '$empNum'");
                    $KilburnazonDB->updateQuery("Department_Details", "Employee_Count = (SELECT COUNT(ID) FROM $empDept)", "Name = '$empDept'");
                    $KilburnazonDB->getDBConnection()->commit();
                    $_SESSION['employeeDeleted'] = TRUE;
                    return TRUE;
                } catch (Exception $E) {
                    // Rollback The State Of The Database If The Transaction Fails
                    $KilburnazonDB->getDBConnection()->rollback();
                    return FALSE;
                }
            }
        }
    }
    return FALSE;
}

// Function To Get An Employees' Details To Show When Updating That Employees' Details
function getEmployeeDetails($empNIN)
{
    global $KilburnazonDB;
    if (isset($_SESSION['encryptedKeys'])) {
        foreach ($_SESSION['encryptedKeys'] as $encryptedDetails) {
            if ($encryptedDetails[0] == $empNIN) {
                $decryptedEmpNIN = decryptEmployeeNumber($encryptedDetails);
                $getDetails = $KilburnazonDB->selectQuery(
                    "Employees.Number, Employee_Details.First_Name, Employee_Details.Last_Name, Employee_Details.Street_Address, Employee_Details.City, Employee_Details.Postcode, Employee_Details.NIN, Employee_Details.Salary, Employee_Details.DOB, Emergency_Contacts.First_Name AS emFN, Emergency_Contacts.Last_Name emLN, Emergency_Contacts.Relationship, Emergency_Contacts.Phone_Number, Departments.Name",
                    "Employee_Details",
                    "INNER JOIN Employees ON Employees.NIN = Employee_Details.NIN INNER JOIN Emergency_Contacts ON Emergency_Contacts.Employee_Number = Employees.Number INNER JOIN Departments ON Departments.Number = Employees.Department_Number",
                    "Employee_Details.NIN = '$decryptedEmpNIN'",
                    "LIMIT 1"
                );
                if ($getDetails != FALSE) {
                    return $getDetails;
                }
                return FALSE;
            }
        }
    }
    return FALSE;
}

// Function Called To Update The Employees' Details In The Respective Tables
function updateEmployeeForm(
    $empNumber,
    $fName,
    $lName,
    $streetAddress,
    $City,
    $postCode,
    $NIN,
    $Salary,
    $ecFName,
    $ecLName,
    $Relationship,
    $ecPhoneNumber
) {
    global $KilburnazonDB;

    try {
        // Create A Transaction When Updating Into Multiple Tables
        $KilburnazonDB->getDBConnection()->begin_transaction();
        $KilburnazonDB->updateQuery(
            "Employee_Details",
            "First_Name = '$fName', Last_Name = '$lName', Street_Address = '$streetAddress', City = '$City', Postcode = '$postCode', Salary = '$Salary'",
            "NIN = '$NIN'"
        );
        $KilburnazonDB->updateQuery(
            "Emergency_Contacts",
            "First_Name = '$ecFName', Last_Name = '$ecLName', Relationship = '$Relationship', Phone_Number = '$ecPhoneNumber'",
            "Employee_Number = '$empNumber'"
        );
        $KilburnazonDB->getDBConnection()->commit();
        $_SESSION["employeeUpdated"] = TRUE;
        return TRUE;
    } catch (Exception $E) {
        // Rollback The State Of The Database If The Transaction Fails
        $KilburnazonDB->getDBConnection()->rollback();
        return FALSE;
    }
}
