<?php
session_start();
// Turn off all error reporting
error_reporting(0);
if (isset($_POST['classique'])) {
  $_SESSION['subscription'] = "Classique";
  header('location: subscription.php');
}

if (isset($_POST['passion'])) {
  $_SESSION['subscription'] = "Passion";
  header('location: subscription.php');
}

if (isset($_POST['1-day'])) {
  $_SESSION['subscription'] = "1-day";
  header('location: subscription.php');
}

if (isset($_POST['7-day'])) {
  $_SESSION['subscription'] = "7-day";
  header('location: subscription.php');
}



?>

<?php include('../../php/head.php'); ?>
    <!-- Page Content -->
    <div class="container full-page test pad-bot min-width">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h1>Register</h1>
                <p class="lead">Choose a subscription</p>
            </div>
        </div>
        <form method="post">
          <div class="row center mar-bot">
            <div class="btn-group" role="group" aria-label="...">
              <input type="submit" name="classique" value="Vélib' Classique" class="btn btn-primary btn-lg">
              <input type="submit" name="passion" value="Vélib' Passion" class="btn btn-primary btn-lg">
            </div>
        </div>

        <div class="row center">
          <div class="btn-group" role="group" aria-label="...">
            <input type="submit" name="1-day" value="1-day ticket" class="btn btn-default btn-lg">
            <input type="submit" name="7-day" value="7-day ticket" class="btn btn-default btn-lg">
          </div>
        </div>
      </form>

    </div>

<?php include('../../php/foot.php'); ?>
