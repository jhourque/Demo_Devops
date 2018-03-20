<?php


$hello = "Hello world";
$date = date('Y/m/d H:i:s');

$serverIP = $_SERVER['SERVER_ADDR'];
?>

<html>
<body bgcolor="#FAE6E6">
<h2>
<?php echo $hello; ?>
</h2>
<p>The time is <?php echo $date; ?></p>
<p>Server IP is <?php echo $serverIP; ?></p>
</body>
</html>
