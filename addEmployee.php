<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee · Kilburnazon</title>
    <?php
    include_once "accountNavBar.php";
    unset($_SESSION['encryptedEmployeeNum']);
    ?>
    <style>
        header nav ul li a[href='addEmployee.php'] {
            color: #4CE970;
        }
    </style>
</head>

<body>
    <div class="Container">
        <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post" accept-charset="utf-8" onsubmit="return validateEmployeeForm(document.getElementById('empID').value.trim(), document.getElementById('firstName').value.trim(), document.getElementById('lastName').value.trim(), document.getElementById('streetAddress').value.trim(), document.getElementById('City').value.trim(), document.getElementById('postCode').value.trim(), document.getElementById('NIN').value.trim(), document.getElementById('DOB').value.trim(), document.getElementById('Salary').value.trim(), document.getElementById('ecFName').value.trim(), document.getElementById('ecLName').value.trim(), document.getElementById('Relationship').value.trim(), document.getElementById('employeePhoneNumber').value.trim(), document.getElementById('departmentName').value.trim())">
            <div class="titleContainer">
                <h3>Add Employee</h3>
                <h6>Kilburnazon · For Company Use Only</h6>
                <?php
                if (isset($_POST["insertEmployee"])) {
                    $addEmployee = addEmployeeForm(
                        cleanInput($_POST["empID"]),
                        cleanInput($_POST["firstName"]),
                        cleanInput($_POST["lastName"]),
                        cleanInput($_POST["streetAddress"]),
                        cleanInput($_POST["City"]),
                        strtoupper(cleanInput($_POST["postCode"])),
                        preg_replace('/\s+/', '', cleanInput($_POST["NIN"])),
                        cleanInput($_POST["DOB"]),
                        round((float)substr(cleanInput($_POST["Salary"]), 2), 2),
                        cleanInput($_POST["ecFName"]),
                        cleanInput($_POST["ecLName"]),
                        cleanInput($_POST["Relationship"]),
                        cleanInput($_POST["employeePhoneNumber"]),
                        cleanInput($_POST["departmentName"])
                    );
                    if ($addEmployee != NULL && $addEmployee == FALSE)
                        echo "<div class=errorBox><div class=errorMessage>Error: Failed To Add The Employee To Kilburnazon</div></div>";
                    else if (isset($_SESSION["employeeInserted"]) && $_SESSION["employeeInserted"]) {
                        echo "<div class=errorBox style='background-color: #DFF2BF; border-color: #4F8A10;'><div class=errorMessage style='color: #4F8A10;'>Successfully Added The Employee To Kilburnazon</div></div>";
                        unset($_SESSION["employeeInserted"], $_POST);
                    }
                }
                ?>
            </div>
            <div class="leftContainer">
                <div class="inputClass">
                    <input placeholder="Employee Number" type="text" name="empID" id="empID" onfocus="changeBorderFocused('empID')" onblur="changeBorderBackToOriginal('empID')" value="<?php echo isset($_POST["empID"]) ? $_POST["empID"] : "" ?>" maxlength="10" onkeypress="addHyphenEmployeeNumber(event)">
                    <span id="empIDError">
                        <?php
                        if (isset($_SESSION["alreadyExistsNum"])) {
                            echo "<div class=errorJS>" . $_SESSION['alreadyExistsNum'] . "</div>";
                            unset($_SESSION["alreadyExistsNum"]);
                        }
                        ?>
                    </span>
                </div>
                <div class="inputClass Name">
                    <div class="Name">
                        <input placeholder="First Name" name="firstName" type="text" id="firstName" onfocus="changeBorderFocused('firstName')" onblur="changeBorderBackToOriginal('firstName')" value="<?php echo isset($_POST["firstName"]) ? $_POST["firstName"] : "" ?>">
                        <span id="firstNameError"></span>
                    </div>
                    <div class="Name">
                        <input placeholder="Last Name" name="lastName" type="text" id="lastName" onfocus="changeBorderFocused('lastName')" onblur="changeBorderBackToOriginal('lastName')" value="<?php echo isset($_POST["lastName"]) ? $_POST["lastName"] : "" ?>">
                        <span id="lastNameError"></span>
                    </div>
                </div>
                <div class="inputClass">
                    <input placeholder="Street Address" name="streetAddress" type="text" id="streetAddress" onfocus="changeBorderFocused('streetAddress')" onblur="changeBorderBackToOriginal('streetAddress')" value="<?php echo isset($_POST["streetAddress"]) ? $_POST["streetAddress"] : "" ?>">
                    <span id="streetAddressError"></span>
                </div>
                <div class="inputClass addressDetails">
                    <div class="addressDetails">
                        <select name="City" id="City">
                            <option disabled selected value="">City</option>
                            <?php displayUKCities($_POST["City"]); ?>
                        </select>
                        <span id="cityError"></span>
                    </div>
                    <div class="addressDetails">
                        <input placeholder="Postcode" name="postCode" type="text" id="postCode" onfocus="changeBorderFocused('postCode')" onblur="changeBorderBackToOriginal('postCode')" value="<?php echo isset($_POST["postCode"]) ? $_POST["postCode"] : "" ?>">
                        <span id="postCodeError"></span>
                    </div>
                </div>
                <div class="inputClass">
                    <input placeholder="National Insurance Number" name="NIN" type="text" id="NIN" onfocus="changeBorderFocused('NIN')" onblur="changeBorderBackToOriginal('NIN')" value="<?php echo isset($_POST["NIN"]) ? $_POST["NIN"] : "" ?>">
                    <span id="ninError">
                        <?php
                        if (isset($_SESSION["alreadyExistsNIN"])) {
                            echo "<div class=errorJS>" . $_SESSION['alreadyExistsNIN'] . "</div>";
                            unset($_SESSION["alreadyExistsNIN"]);
                        }
                        ?>
                    </span>
                </div>
                <div class="inputClass Details">
                    <div class="Details">
                        <input placeholder="Date Of Birth" type="text" name="DOB" id="DOB" onfocus="changeBorderFocused('DOB')" onblur="changeBorderBackToOriginal('DOB')" value="<?php echo isset($_POST["DOB"]) ? $_POST["DOB"] : "" ?>" onfocusin="(this.type='date')" onfocusout="(this.type='text')" onclick="setMaxDate(document.getElementById('DOB'))" min="1950-01-01">
                        <span id="dobError"></span>
                    </div>
                    <div class="Details">
                        <input placeholder="Salary Per Annum" name="Salary" type="text" id="Salary" onfocus="changeBorderFocused('Salary')" onblur="changeBorderBackToOriginal('Salary')" value="<?php echo isset($_POST["Salary"]) ? $_POST["Salary"] : "" ?>" onkeypress="validateSalary(document.getElementById('Salary'), event)">
                        <span id="salaryError"></span>
                    </div>
                </div>
            </div>
            <div class="rightContainer">
                <div class="inputClass">
                    <input placeholder="Emergency Contact First Name" name="ecFName" type="text" id="ecFName" onfocus="changeBorderFocused('ecFName')" onblur="changeBorderBackToOriginal('ecFName')" value="<?php echo isset($_POST["ecFName"]) ? $_POST["ecFName"] : "" ?>">
                    <span id="ecFNameError"></span>
                </div>
                <div class="inputClass">
                    <input placeholder="Emergency Contact Last Name" name="ecLName" type="text" id="ecLName" onfocus="changeBorderFocused('ecLName')" onblur="changeBorderBackToOriginal('ecLName')" value="<?php echo isset($_POST["ecLName"]) ? $_POST["ecLName"] : "" ?>">
                    <span id="ecLNameError"></span>
                </div>
                <div class="inputClass">
                    <input placeholder="Relationship" name="Relationship" type="text" id="Relationship" onfocus="changeBorderFocused('Relationship')" onblur="changeBorderBackToOriginal('Relationship')" value="<?php echo isset($_POST["Relationship"]) ? $_POST["Relationship"] : "" ?>">
                    <span id="relationshipError"></span>
                </div>
                <div class="inputClass">
                    <input placeholder="Emergency Contact Phone Number" name="employeePhoneNumber" type="text" id="employeePhoneNumber" onfocus="changeBorderFocused('employeePhoneNumber')" onblur="changeBorderBackToOriginal('employeePhoneNumber')" onkeypress="validatePhoneNumber(event)" maxlength="11" value="<?php echo isset($_POST["employeePhoneNumber"]) ? $_POST["employeePhoneNumber"] : "" ?>">
                    <span id="phoneNumberError"></span>
                </div>
                <div class="inputClass">
                    <select name="departmentName" id="departmentName">
                        <option disabled selected value="">Select Department</option>
                        <?php displayDepartmentOptions($_POST["departmentName"]); ?>
                    </select>
                    <span id="departmentNameError"></span>
                </div>
                <div class="inputClass">
                    <input name="insertEmployee" type="submit" value="Insert Employee">
                </div>
            </div>
        </form>
    </div>
</body>

</html>