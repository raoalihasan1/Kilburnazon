<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search · Kilburnazon</title>
    <script src="https://kit.fontawesome.com/167b7ecae5.js" crossorigin="anonymous"></script>
    <?php
    include_once "accountNavBar.php";
    ?>
    <style>
        header nav ul li a[href='searchKilburnazon.php'] {
            color: #4CE970;
        }
    </style>
</head>

<body>
    <div class="searchBar">
        <form class="searchEmployee" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post" onsubmit="return atLeastOneSearchCriteria(document.getElementById('empID').value.trim(), document.getElementById('employeeFName').value.trim(), document.getElementById('employeeLName').value.trim(), document.getElementById('emergencyRelationships').value.trim(), document.getElementById('employeeDepartment').value.trim())">
            <div class="inputClass">
                <div class="inputElements">
                    <input placeholder="Employee Number" type="text" name="empID" id="empID" onfocus="changeBorderFocused('empID')" onblur="changeBorderBackToOriginal('empID')" onkeypress="addHyphenEmployeeNumber(event)" maxlength="10">
                </div>
                <div class="inputElements">
                    <input placeholder="Employee First Name" type="text" name="employeeFName" id="employeeFName" onfocus="changeBorderFocused('employeeFName')" onblur="changeBorderBackToOriginal('employeeFName')">
                </div>
                <div class="inputElements">
                    <input placeholder="Employee Last Name" type="text" name="employeeLName" id="employeeLName" onfocus="changeBorderFocused('employeeLName')" onblur="changeBorderBackToOriginal('employeeLName')">
                </div>
            </div>
            <div class="inputClass searchEmployee">
                <select name="emergencyRelationships" id="emergencyRelationships">
                    <option value="" selected>Contacts Relationship To Employee</option>
                    <?php displayEmergencyContactRelationships(); ?>
                </select>
                <select name="employeeDepartment" id="employeeDepartment">
                    <option value="" selected>Department</option>
                    <?php displayDepartmentOptions(null); ?>
                </select>
                <button type="submit" name="Search">Search</button>
            </div>
        </form>
        <form class="displayProcedures" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post" onsubmit="return emptyCallToProcedure(document.getElementById('callProcedure').value)">
            <select name="callProcedure" id="callProcedure">
                <option value="" disabled selected>Procedures</option>
                <?php displayProcedures() ?>
            </select>
            <button type="submit" name="Call">Call</button>
        </form>
    </div>
    <?php
    if (isset($_POST["Search"])) searchResult(cleanInput($_POST['empID']), cleanInput($_POST['employeeFName']), cleanInput($_POST['employeeLName']), cleanInput($_POST['employeeDepartment']), cleanInput($_POST['emergencyRelationships']));
    else if (isset($_POST["Call"])) showProcedure(cleanInput(($_POST['callProcedure'])));
    else if (isset($_SESSION["employeeDeleted"]) && $_SESSION["employeeDeleted"]) {
        echo "<div class=resultContainer style='background: #0BAA30;'><div id=emptyNotes>Employee Deleted Successfully</div></div>";
        unset($_SESSION["employeeDeleted"]);
    } else echo "<div class=resultContainer><div id=emptyNotes>Search For Employees Or See The Results Of Procedures <i class='fa fa-search' aria-hidden=true></i></div></div>";
    ?>
</body>

</html>