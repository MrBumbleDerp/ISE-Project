<?php include('../../php/head.php'); ?>
<?php

if (isset($_SESSION['bike'])) // if the user is renting a bike
{
  if (isset($_POST['returnbike']))
  {
    // TODO: update bike, post, rental
  }
}
 ?>
    <!-- Page Content -->
    <div class="container full-page test min-width ">
        <div class="row"> 
            <div class="col-lg-12 text-center">
                <h1>Return a bike</h1>
                <p class="lead">This is a V+ station</p>
            </div>
        </div>
        <div class="row center">
          <div class="btn-group" role="group" aria-label="...">
            <input type="submit" name="returnbike" value="Return Bike" class="btn btn-primary btn-lg mar-bot2" onclick="changecolors()">
            <button type="button" class="btn btn-primary btn-lg mar-bot2" onclick="changecolors()">Return Bike</button>
          </div>
      </div>
    </div>

    <script>
    var x;

  function changecolors() {
      x = 1;
      setInterval(myFunction, 1000);
  }

  function myFunction() {
      if (x === 1) {
          color = "#f7ad00";
          x = 2;
      } else if (x == 2){
          color = "#afb608";
          x = 3;
      }
      else if (x == 3) {
        window.location.href = "successfullreturnbike.php";
      }
      document.body.style.background = color;
  }
    </script>

<?php include('../../php/foot.php') ?>
