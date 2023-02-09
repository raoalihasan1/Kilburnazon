function preventResubmissionOnRefresh()
{
    if (window.history.replaceState) window.history.replaceState(null, null, window.location.href);    
}

function changeBorderBackToOriginal(x)
{
    document.getElementById(x).style.borderColor = "#AAA6A6";
    if (document.getElementById(x).value == "") {
        document.getElementById(x).classList.remove("inputField");
        document.getElementById(x).style.transition = "0.425s";
    }
}

function changeBorderFocused(x)
{
    document.getElementById(x).style.transition = "0.425s";
    document.getElementById(x).style.borderColor = "#021B34";
    document.getElementById(x).classList.add("inputField");
}

function isValidEmployeeNumber(x) {
    return x.match(/^[0-9]{2}-[0-9]{7}$/i) ? true : false;
}

function isValidName(x) {
    return x.match(/[^a-zA-Z ]/g) ? false : true;
}

function isValidPostcode(x) {
    return x.match(/^[A-Z]{1,2}[0-9]{1,2}[A-Z]{0,1} ?[0-9][A-Z]{2}$/i) ? true : false;
}

function validatePhoneNumber(event) {
    if (event.which > 31 && (event.which < 48 || event.which > 57))
        event.preventDefault();
}

function isValidPhoneNumber(x) {
    return x.match(/^0\d{10}$/i) ? true : false;
}

function isValidSalary(x) {
    return x.match(/^£\d+(\.?)\d{0,2}$/i) ? true : false;
}

function isValidNIN(x) {
    return x.match(/^(?!BG)(?!GB)(?!NK)(?!KN)(?!TN)(?!NT)(?!ZZ)(?:[A-CEGHJ-PR-TW-Z][A-CEGHJ-NPR-TW-Z])(?:\s*\d\s*){6}([A-D]|\s)$/i) ? true : false;
}

function setMaxDate(x) {
    x.max = new Date().toISOString().split("T")[0];
}

function addHyphenEmployeeNumber(event) {
    if (document.getElementById('empID').value.length == 2)
        document.getElementById('empID').value += "-";
    if (event.which > 31 && (event.which < 48 || event.which > 57)) event.preventDefault();
}

function validateSalary(x, event) {
    if (x.value.indexOf('£') != 0) {
        if (x.value.indexOf('£') == -1) {
            x.value = "£" + x.value;
        } 
    }
    if (event.which != 46 && event.which > 31 && (event.which < 48 || event.which > 57)) event.preventDefault();
}

function atLeastOneSearchCriteria(empID, empFName, empLName, emergencyRelationship, empDept) {
    return empID != "" || empFName != "" || empLName != "" || emergencyRelationship != "" || empDept != "";
}

function emptyCallToProcedure(Procedure) {
    return Procedure != "";
}

function validateEmployeeForm(empID, fName, lName, streetAdress, City, postCode, NIN, DOB, Salary, ecFName, ecLName, Relationship, employeePhoneNumber, departmentName)
{
    let errorEmpID = document.getElementById('empIDError');
    let errorFName = document.getElementById('firstNameError');
    let errorLName = document.getElementById('lastNameError');
    let errorStreetAddress = document.getElementById('streetAddressError');
    let errorCity = document.getElementById('cityError');
    let errorPostCode = document.getElementById('postCodeError');
    let errorNIN = document.getElementById('ninError');
    let errorDOB = document.getElementById('dobError');
    let errorSalary = document.getElementById('salaryError');
    let errorECFName = document.getElementById('ecFNameError');
    let errorECLName = document.getElementById('ecLNameError');
    let errorRelationship = document.getElementById('relationshipError');
    let errorPhoneNumber = document.getElementById('phoneNumberError');
    let errorDepartmentName = document.getElementById('departmentNameError');

    if (empID == "")
        errorEmpID.innerHTML = "<div class=errorJS>Enter The Employee Number</div>";
    else if (!isValidEmployeeNumber(empID.trim()))
        errorEmpID.innerHTML = "<div class=errorJS>Employee Number Format Is Invalid</div>";
    else
        errorEmpID.innerHTML = "";
    
    if (fName == "")
        errorFName.innerHTML = "<div class=errorJS>Enter First Name</div>";
    else if (!isValidName(fName.trim()))
        errorFName.innerHTML = "<div class=errorJS>First Name Is Invalid</div>";
    else
        errorFName.innerHTML = "";
    
    if (lName == "")
        errorLName.innerHTML = "<div class=errorJS>Enter Last Name</div>";
    else if (!isValidName(lName.trim()))
        errorLName.innerHTML = "<div class=errorJS>Last Name Is Invalid</div>";
    else
        errorLName.innerHTML = "";
    
    if (streetAdress == "")
        errorStreetAddress.innerHTML = "<div class=errorJS>Enter Street Address</div>";
    else
        errorStreetAddress.innerHTML = "";
    
    if (City == "")
        errorCity.innerHTML = "<div class=errorJS>Enter City Of Residence</div>";
    else
        errorCity.innerHTML = "";
    
    if (postCode == "")
        errorPostCode.innerHTML = "<div class=errorJS>Enter Postcode</div>";
    else if (!isValidPostcode(postCode.trim()))
        errorPostCode.innerHTML = "<div class=errorJS>Postcode Is Invalid</div>";
    else
        errorPostCode.innerHTML = "";
    
    if (NIN == "")
        errorNIN.innerHTML = "<div class=errorJS>Enter National Insurance Number</div>";
    else if (!isValidNIN(NIN.trim().toUpperCase()))
        errorNIN.innerHTML = "<div class=errorJS>National Insurance Number Is Invalid</div>";
    else
        errorNIN.innerHTML = "";
    
    if (DOB == "")
        errorDOB.innerHTML = "<div class=errorJS>Enter Date Of Birth</div>";
    else if (DOB > (new Date().toISOString().split("T")[0]) || DOB < document.getElementById('DOB').min)
        errorDOB.innerHTML = "<div class=errorJS>DOB Is Invalid</div>";
    else
        errorDOB.innerHTML = "";
    
    if (Salary == "" || Salary == "£")
        errorSalary.innerHTML = "<div class=errorJS>Enter Salary</div>";
    else if (!isValidSalary(Salary.trim()) || parseFloat(Salary.substr(1)) == 0)
        errorSalary.innerHTML = "<div class=errorJS>Salary Is Invalid</div>";
    else
        errorSalary.innerHTML = "";
    
    if (ecFName == "")
        errorECFName.innerHTML = "<div class=errorJS>Enter The Contacts First Name</div>";
    else if (!isValidName(ecFName.trim()))
        errorECFName.innerHTML = "<div class=errorJS>First Name Is Invalid</div>";
    else
        errorECFName.innerHTML = "";
    
    if (ecLName == "")
        errorECLName.innerHTML = "<div class=errorJS>Enter The Contacts Last Name</div>";
    else if (!isValidName(ecLName.trim()))
        errorECLName.innerHTML = "<div class=errorJS>Last Name Is Invalid</div>";
    else
        errorECLName.innerHTML = "";
    
    if (Relationship == "")
        errorRelationship.innerHTML = "<div class=errorJS>Enter The Contacts Relationship To The Employee</div>";
    else
        errorRelationship.innerHTML = "";
    
    if (employeePhoneNumber == "")
        errorPhoneNumber.innerHTML = "<div class=errorJS>Enter The Contacts Phone Number</div>";
    else if (!isValidPhoneNumber(employeePhoneNumber.trim()) || employeePhoneNumber.lenngth < 11)
        errorPhoneNumber.innerHTML = "<div class=errorJS>Phone Number Is Invalid</div>";
    else
        errorPhoneNumber.innerHTML = "";
    
    if (departmentName == "")
        errorDepartmentName.innerHTML = "<div class=errorJS>Select The Department Of The Employee</div>";
    else
        errorDepartmentName.innerHTML = "";
        
    return empID != "" && fName != "" && lName != "" && streetAdress != "" && City != "" && postCode != "" && NIN != "" && DOB != "" &&
        (Salary != "" || Salary != "£") && ecFName != "" && ecLName != "" && Relationship != "" && employeePhoneNumber != ""
        && departmentName != "";
}

function validateForm(empID, NIN)
{
    let errorEmpID = document.getElementById('employeeNumError');
    let errorNIN = document.getElementById('ninError');

    if (empID == "")
        errorEmpID.innerHTML = "<div class=errorJS>Enter The Employee Number</div>";
    else
        errorEmpID.innerHTML = "";

    if (NIN == "")
        errorNIN.innerHTML = "<div class=errorJS>Enter National Insurance Number</div>";
    else
        errorNIN.innerHTML = "";
    
    return empID != "" && NIN != "";
}

preventResubmissionOnRefresh();