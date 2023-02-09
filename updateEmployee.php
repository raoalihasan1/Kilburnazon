<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Employee · Kilburnazon</title>
    <?php include_once "accountNavBar.php"; ?>
    <?php !isset($_SESSION['encryptedEmployeeNum']) ? header("Location: searchKilburnazon.php") : NULL; ?>

</head>

<body>
    <div class="Container">
        <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post" accept-charset="utf-8" onsubmit="return validateEmployeeForm(document.getElementById('empID').value.trim(), document.getElementById('firstName').value.trim(), document.getElementById('lastName').value.trim(), document.getElementById('streetAddress').value.trim(), document.getElementById('City').value.trim(), document.getElementById('postCode').value.trim(), document.getElementById('NIN').value.trim(), document.getElementById('DOB').value.trim(), document.getElementById('Salary').value.trim(), document.getElementById('ecFName').value.trim(), document.getElementById('ecLName').value.trim(), document.getElementById('Relationship').value.trim(), document.getElementById('employeePhoneNumber').value.trim(), document.getElementById('departmentName').value.trim())">
            <div class=" titleContainer">
                <h3>Update Details</h3>
                <h6>Kilburnazon · For Company Use Only</h6>
                <?php
                if (isset($_POST["updateEmployee"])) {
                    $updateEmployee = updateEmployeeForm(
                        getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Number"],
                        cleanInput($_POST["firstName"]),
                        cleanInput($_POST["lastName"]),
                        cleanInput($_POST["streetAddress"]),
                        cleanInput($_POST["City"]),
                        strtoupper(cleanInput($_POST["postCode"])),
                        getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["NIN"],
                        round((float)substr(cleanInput($_POST["Salary"]), 2), 2),
                        cleanInput($_POST["ecFName"]),
                        cleanInput($_POST["ecLName"]),
                        cleanInput($_POST["Relationship"]),
                        cleanInput($_POST["employeePhoneNumber"])
                    );
                    if ($updateEmployee == FALSE)
                        echo "<div class=errorBox><div class=errorMessage>Error: Failed To Update The Employees' Details</div></div>";
                    else if (isset($_SESSION["employeeUpdated"]) && $_SESSION["employeeUpdated"]) {
                        echo "<div class=errorBox style='background-color: #DFF2BF; border-color: #4F8A10;'><div class=errorMessage style='color: #4F8A10;'>Successfully Updated The Employees' Details</div></div>";
                        unset($_SESSION["employeeUpdated"], $_POST);
                    }
                }
                ?>
            </div>
            <div class="leftContainer">
                <div class="inputClass">
                    <input type="text" id="empID" value="<?php echo getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Number"] ?>" disabled>
                    <span id="empIDError"></span>
                </div>
                <div class="inputClass Name">
                    <div class="Name">
                        <input placeholder="First Name" name="firstName" type="text" id="firstName" onfocus="changeBorderFocused('firstName')" onblur="changeBorderBackToOriginal('firstName')" value="<?php echo isset($_POST["firstName"]) ? $_POST["firstName"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["First_Name"] ?>">
                        <span id="firstNameError"></span>
                    </div>
                    <div class="Name">
                        <input placeholder="Last Name" name="lastName" type="text" id="lastName" onfocus="changeBorderFocused('lastName')" onblur="changeBorderBackToOriginal('lastName')" value="<?php echo isset($_POST["lastName"]) ? $_POST["lastName"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Last_Name"] ?>">
                        <span id="lastNameError"></span>
                    </div>
                </div>
                <div class="inputClass">
                    <input placeholder="Street Address" name="streetAddress" type="text" id="streetAddress" onfocus="changeBorderFocused('streetAddress')" onblur="changeBorderBackToOriginal('streetAddress')" value="<?php echo isset($_POST["streetAddress"]) ? $_POST["streetAddress"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Street_Address"] ?>">
                    <span id="streetAddressError"></span>
                </div>
                <div class="inputClass addressDetails">
                    <div class="addressDetails">
                        <select name="City" id="City">
                            <option disabled selected value="">City</option>
                            <?php displayUKCities(isset($_POST["City"]) ? $_POST["City"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["City"]); ?>
                        </select>
                        <span id="cityError"></span>
                    </div>
                    <div class="addressDetails">
                        <input placeholder="Postcode" name="postCode" type="text" id="postCode" onfocus="changeBorderFocused('postCode')" onblur="changeBorderBackToOriginal('postCode')" value="<?php echo isset($_POST["postCode"]) ? $_POST["postCode"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Postcode"] ?>">
                        <span id="postCodeError"></span>
                    </div>
                </div>
                <div class="inputClass">
                    <input type="text" id="NIN" value="<?php echo getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["NIN"] ?>" disabled>
                    <span id="ninError"></span>
                </div>
                <div class="inputClass Details">
                    <div class="Details">
                        <input type="text" id="DOB" name="DOB" value="<?php echo getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["DOB"] ?>" disabled>
                        <span id="dobError"></span>
                    </div>
                    <div class="Details">
                        <input placeholder="Salary Per Annum" name="Salary" type="text" id="Salary" onfocus="changeBorderFocused('Salary')" onblur="changeBorderBackToOriginal('Salary')" value="<?php echo isset($_POST["Salary"]) ? $_POST["Salary"] : "£" . getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Salary"] ?>" onkeypress="validateSalary(document.getElementById('Salary'), event)">
                        <span id="salaryError"></span>
                    </div>
                </div>
            </div>
            <div class="rightContainer">
                <div class="inputClass">
                    <input placeholder="Emergency Contact First Name" name="ecFName" type="text" id="ecFName" onfocus="changeBorderFocused('ecFName')" onblur="changeBorderBackToOriginal('ecFName')" value="<?php echo isset($_POST["ecFName"]) ? $_POST["ecFName"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["emFN"] ?>">
                    <span id="ecFNameError"></span>
                </div>
                <div class="inputClass">
                    <input placeholder="Emergency Contact Last Name" name="ecLName" type="text" id="ecLName" onfocus="changeBorderFocused('ecLName')" onblur="changeBorderBackToOriginal('ecLName')" value="<?php echo isset($_POST["ecLName"]) ? $_POST["ecLName"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["emLN"] ?>">
                    <span id="ecLNameError"></span>
                </div>
                <div class="inputClass">
                    <input placeholder="Relationship" name="Relationship" type="text" id="Relationship" onfocus="changeBorderFocused('Relationship')" onblur="changeBorderBackToOriginal('Relationship')" value="<?php echo isset($_POST["Relationship"]) ? $_POST["Relationship"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Relationship"] ?>">
                    <span id="relationshipError"></span>
                </div>
                <div class="inputClass">
                    <input placeholder="Emergency Contact Phone Number" name="employeePhoneNumber" type="text" id="employeePhoneNumber" onfocus="changeBorderFocused('employeePhoneNumber')" onblur="changeBorderBackToOriginal('employeePhoneNumber')" onkeypress="validatePhoneNumber(event)" maxlength="11" value="<?php echo isset($_POST["employeePhoneNumber"]) ? $_POST["employeePhoneNumber"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Phone_Number"] ?>">
                    <span id="phoneNumberError"></span>
                </div>
                <div class="inputClass">
                    <select name="departmentName" id="departmentName" disabled>
                        <option disabled selected value="">Select Department</option>
                        <?php displayDepartmentOptions(isset($_POST["departmentName"]) ? $_POST["departmentName"] : getEmployeeDetails($_SESSION['encryptedEmployeeNum'])[0]["Name"]); ?>
                    </select>
                    <span id="departmentNameError"></span>
                </div>
                <div class="inputClass">
                    <input name="updateEmployee" type="submit" value="Update Employee">
                </div>
            </div>
        </form>
    </div>
</body>

</html>