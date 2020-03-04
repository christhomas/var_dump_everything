<?php
session_start();
$_SESSION['auto_generated_time'] = new DateTime('now');

function cut($str)
{
	$censored = '(censored)';

	if(strpos($str, $censored) !== false) return $str;

	$len = strlen($str);
	$len = $len === 0 ? $len : $len/2;

	$str = substr($str, 0, $len);

	if($len === 0) $str = '(was empty)';

	return $str . $censored;
}

function dump($arr)
{
	ksort($arr);
	foreach(array_keys($arr) as $k){
		$lk = strtolower($k);

		if(strpos($lk, "password")	!== false)	$arr[$k] = cut($arr[$k]);
		if(strpos($lk, "key")		!== false)	$arr[$k] = cut($arr[$k]);
		if(strpos($lk, "secret")	!== false)	$arr[$k] = cut($arr[$k]);
		if(strpos($lk, "encrypt")	!== false)	$arr[$k] = cut($arr[$k]);
		if(strpos($lk, "token")		!== false)	$arr[$k] = cut($arr[$k]);
	}

	print("<pre>");
	var_dump($arr);
	print("</pre>");
}
?>
<!doctype html>
<html>
<head>
	<title>Var Dump Everything</title>
	<style type="text/css">
		pre {
			margin: 0 0 0 2rem;
			background: #fdf7d7;
		}
	</style>
</head>
<body>
	<p>VAR DUMPING SERVER:</p>
	<?php dump($_SERVER)?>

	<p>VAR DUMPING ENV:</p>
    <?php dump($_ENV)?>

	<p>VAR DUMPING POST:</p>
    <?php dump($_POST)?>

	<p>VAR DUMPING GET:</p>
    <?php dump($_GET)?>

	<p>VAR DUMPING HEADERS:</p>
    <?php dump(getallheaders())?>

	<p>VAR DUMPING SESSION:</p>
    <?php dump($_SESSION)?>

	<p>VAR DUMPING FILES:</p>
    <?php dump($_FILES)?>

	<p>VAR DUMPING COOKIE:</p>
    <?php dump($_COOKIE)?>

	<p>VAR DUMPING REQUEST:</p>
    <?php dump($_REQUEST)?>
</body>
</html>





