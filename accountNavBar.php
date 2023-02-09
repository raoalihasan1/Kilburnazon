<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="Kilburnazon.js"></script>
    <link rel="stylesheet" href="accountStyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <?php
    include_once "kilburnazonManagement.php";
    !isset($_SESSION['loggedInEmployee']) ? header("Location: logIn.php") : NULL;
    $Employee = unserialize($_SESSION['loggedInEmployee']);
    ?>
</head>

<body>
    <header>
        <a href="searchKilburnazon.php">
            <img src="kilburnazonLogo.png">
        </a>
        <nav>
            <ul>
                <li><a href="addEmployee.php">Add Employees</a></li>
                <li><a href="searchKilburnazon.php">Search</a></li>
                <li>
                    <a id="logOutDropDown" onclick='document.getElementById("dropDown").classList.toggle("showDropDown")'>
                        <?php echo $Employee->getFirstName() . " " . $Employee->getLastName(); ?>
                        <i class="fa fa-caret-down"></i>
                    </a>
                    <div id="dropDown">
                        <form method=post><button type=submit name=logOut>Log Out</button></form>
                    </div>
                </li>
            </ul>
        </nav>
    </header>
</body>

</html>

<script>
    window.onclick = function(event) {
        if (!event.target.matches('#logOutDropDown')) {
            var myDropdown = document.getElementById("dropDown");
            if (myDropdown.classList.contains('showDropDown')) {
                myDropdown.classList.remove('showDropDown');
            }
        }
    }
</script>