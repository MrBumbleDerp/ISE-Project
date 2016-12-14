<?php include('../../php/head.php'); ?>
<?php

$bikenumber = $_POST['bikenumber'];

if (isset($_POST['unlock'])) //als er op de knop unlock wordt gedrukt:
{
  if (empty($bikenumber)) {
    echo '<div class="alert alert-danger center min-width content-center" role="alert">Please enter a bike number.</div>';
  }
  //  TODO stored procedure :D
}


 ?>
    <!-- Page Content -->
    <div class="container full-page test min-width">

        <div class="row">
            <div class="col-lg-12 text-center">
                <h1>Rent a bike</h1>
                <p class="lead">Please enter a bikenumber below</p>
            </div>
        </div>
        <div class="row center mar-bot2">
          <input class="form-control input-lg min-width center content-center mar-bot2" name="bikenumber" type="text">
          <div class="btn-group" role="group" aria-label="...">
            <input type="submit" name="unlock" value="Unlock" class="btn btn-primary btn-lg">
            <a href="rentsuccess.php"><button type="button" class="btn btn-primary btn-lg">Unlock</button></a>
          </div>
      </div>
    </div>
<?php include('../../php/foot.php') ?>
