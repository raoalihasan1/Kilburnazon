<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="logInStyles.css">
    <script src="Kilburnazon.js"></script>
    <title>Log In · Kilburnazon</title>
    <?php include_once "kilburnazonManagement.php" ?>
    <?php isset($_SESSION["loggedInEmployee"]) ? header("Location: searchKilburnazon.php") : NULL; ?>
</head>

<body>
    <div class="Container">
        <div class="leftContainer">
            <img src="kilburnazonLogo.png">
        </div>
        <div class="formContainer rightContainer">
            <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post" accept-charset="utf-8" onsubmit="return validateForm(document.getElementById('empID').value, 
            document.getElementById('NIN').value)">
                <h3>Employee Account</h3>
                <h6>Kilburnazon · For Company Use Only</h6>
                <?php
                if (isset($_POST["logIn"])) {
                    $logIn = logInForm(cleanInput($_POST["employeeNum"]), cleanInput($_POST["NIN"]));
                    if ($logIn != null && count($logIn) > 0) {
                        echo "<style> .formContainer form .inputClass label { font-size: 0.625em; top: 17.5%; opacity: 0.375; } </style>";
                        echo "<div class=errorBox>";
                        foreach ($logIn as $Error) {
                            echo "<div class=errorMessage>" . $Error . "</div>";
                        }
                        echo "</div>";
                    }
                }
                ?>
                <div class="inputClass">
                    <input name="employeeNum" maxlength="10" onkeypress="addHyphenEmployeeNumber(event)" type="text" id="empID" onfocus="changeBorderFocused('empID')" onblur="changeBorderBackToOriginal('empID')" value="<?php echo isset($_POST["employeeNum"]) ? $_POST["employeeNum"] : "" ?>">
                    <label for="employeeNum">Employee Number</label>
                    <span id="employeeNumError"></span>
                </div>
                <div class="inputClass">
                    <input name="NIN" type="text" id="NIN" onfocus="changeBorderFocused('NIN')" onblur="changeBorderBackToOriginal('NIN')" value="<?php echo isset($_POST["NIN"]) ? $_POST["NIN"] : "" ?>">
                    <label for="NIN">National Insurance Number</label>
                    <span id="ninError"></span>
                </div>
                <input name="logIn" type="submit" value="Log In">
            </form>
        </div>
    </div>
</body>

</html>