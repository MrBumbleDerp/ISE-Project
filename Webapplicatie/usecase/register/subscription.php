<?php include('../../php/head.php'); ?>
<?php
  // all variables for the user form must be initialized empty in order to use the empty() method
  $subscription = "";
  $subscriptionId = "";
  $Firstname = "";
  $Lastname = "";
  $Emailadress = "";
  $Dateofbirth = "";
  $Address = "";
  $Town = "";
  $Zipcode = "";
  $Creditcard = "";
  $Phonenumber = "";
  $password = "";

  if (isset($_SESSION['subscription']))
  { // if the user clicked on one of the subscriptions, there should be a variable with that name
    $subscription = $_SESSION['subscription']; // set the name of the session variable to $subscription
    $sql = "SELECT id FROM SUBSCRIPTION WHERE NAME = '$subscription'"; //search for the id, which is used in the insert later
    $subscriptionId = sqlsrv_query($conn, $sql OR die(sqlsrv_errors()));;
  }
  else if (!(isset($_SESSION['subscription']))) // if someone managed to change the link without selecting a subscription
  {
    header('location: register.php'); // go back to register page
  }

  if (isset($_POST['Submitbutton'])) // if the user presses 'Submit':
  {

    // insert all values with the ones from the form:
    $Firstname = $_POST['Firstname'];
    $Lastname = $_POST['Lastname'];
    $Emailadress = $_POST['Emailadress'];
    $Dateofbirth = $_POST['Dateofbirth'];
    $Address = $_POST['Address'];
    $Town = $_POST['Town'];
    $Zipcode = $_POST['Zipcode'];
    $Creditcard = $_POST['Creditcard'];
    $Phonenumber = $_POST['Phonenumber'];
    $password = $_POST['password'];

    // Check if values are left empty by user:
    if(empty($Firstname) || empty($Lastname) || empty($Emailadress) || empty($Dateofbirth) || empty($Address) || empty($Town) || empty($Zipcode) || empty($Creditcard) || empty($Phonenumber) || empty($password))
    {
      echo'<div class="alert alert-danger center min-width content-center" role="alert">Uh oh! You have entered an invalid email-adress. Please try again.</div>';
    }
    else { // if all goes well: go to success-page
      sqlsrv_query($conn, "INSERT INTO [USER] (subscriptionId, FirstName, LastName, email, password, dateOfBirth, zipcode, address, town, Creditcard,
        phoneNumber, vPoints, discount, subscriptionStart, subscriptionRefresh, prepaidCard)
      VALUES (1, '$Firstname', '$Lastname', '$Emailadress', '$password', '$Dateofbirth', '$Zipcode', '$Address', '$Town', '$Creditcard',
        '$Phonenumber', 1, 1, '$DateOfBirth', 1, 1") or die( print_r( sqlsrv_errors(), true));
      header('location: successregister.php');
    }
  }

 ?>
    <!-- Page Content -->
    <div class="container full-page min-width">

        <div class="test">

          <div class="row">
              <div class="col-lg-12 text-center">
                  <h1>Vélib' <?php echo $subscription; ?></h1>
                  <p class="lead">Please enter your information</p>
              </div>
          </div>

        <form class="content-center form-inline" method="post">
          <div class="pad-left">
          <div class="row col-md-12">
              <div class="form-group">
                <input type="text" class="form-control" name="Firstname" placeholder="First name">
              </div>
              <div class="form-group">
                <input type="text" class="form-control" name="Lastname" placeholder="Last name">
              </div>
            </div>

            <div class="row col-md-12 mar-top">
                <div class="form-group">
                  <input type="text" class="form-control" name="Emailadress" placeholder="Email-adress">
                </div>
                <div class="form-group">
                  <input type="password" class="form-control" name="password" placeholder="Password">
                </div>
              </div>

              <div class="row col-md-12 mar-top">
                  <div class="form-group">
                    <input type="date" class="form-control" name="Dateofbirth" placeholder="Date of birth">
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="Address" placeholder="Address">
                  </div>
                  <div class="form-group mar-top">
                    <input type="text" class="form-control" name="Town" placeholder="Town">
                  </div>
                  <div class="form-group mar-top">
                    <input type="text" class="form-control" name="Zipcode" placeholder="Zipcode">
                  </div>
                </div>

                <div class="row col-md-12 mar-top">
                    <div class="form-group">
                      <input type="text" class="form-control" name="Creditcard" placeholder="Creditcard">
                    </div>
                    <div class="form-group">
                      <input type="text" class="form-control" name="Phonenumber" placeholder="Phonenumber">
                    </div>
                  </div>
              </div>
                  <div class="row center">
                    <input type="submit" name="Submitbutton" value="Submit" class="btn btn-primary mar-top mar-bot2">
                </div>
              </div>
            </form>
                </div>
              </div>

<?php include('../../php/foot.php') ?>
