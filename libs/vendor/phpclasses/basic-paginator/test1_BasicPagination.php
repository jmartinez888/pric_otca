<html><head><title>BasicPagination test</title>
<style type="text/css">
#t1 {
  border: solid 1px black;
  }
#t1 td {
  text-align:right;
  border-bottom:dotted 1px silver;
  border-right:dotted 1px silver;
  }
a.MyPageLinks {
  font-family:sans-serif;
  text-decoration:none;
  padding:2px 4px;
  font-size:75%;
  background-color:silver;
  }
a.MyPageLinks:hover {
  background-color:black;
  color:white;
  }
  
</style></head><body>
<h1>BasicPagination test</h1>
<p>Setup for 1000 items, 12 items per page, and output max 16 page links separated by a dash:</p>
<pre>
$p = new BasicPagination(1000,"?",12);
$p->offset = (int)$_GET["offset"];
echo $p->PagesHTML(16," - ");
</pre>

<?php

error_reporting(E_ALL);
ini_set('display_errors',1);
date_default_timezone_set('Europe/Paris');

include 'BasicPagination.class.php';

$p = new BasicPagination(1000,"?",12);
echo $p->PagesHTML(16," - ");

?>
<table id="t1">
<tr>
  <td>$i</td>
  <td>$i^7</td>
  <td>(int)($i*sin($i))</td>
  <td>pow($i,2)</td>
</tr>

<?php # test output
$td = '<td>%d</td>';
foreach(range($p->offset+1,min($p->max,$p->offset+$p->itemcount)) as $i) 
  echo sprintf("<tr>$td$td$td$td</tr>",
   $i,$i^7,(int)($i*sin($i)),pow($i,2));
?>
</table>

<p>Set a class and output the pagination links again, with default separator (&amp;nbsp;) and link count (20).</p>
<pre>$p->link_class = 'MyPageLinks';
echo $p->PagesHTML();</pre>

<?php 
$p->link_class = 'MyPageLinks';
echo $p->PagesHTML();
?>

<p>Making individual links:</p>
<pre>$p->link_class = '';
echo '&lt;p>You can make links'.
     ' to '.$p->previouspage('previous').
     ' or '.$p->nextpage('next').
     ' or to '.$p->pagelink(10,'any page').
     '&lt;/p>';
</pre>
<?php
$p->link_class = '';
echo '<p>You can make links'.
     ' to '.$p->previouspage('previous').
     ' or '.$p->nextpage('next').
     ' or to '.$p->pagelink(10,'any page').
     '</p>';

?>
<p>Note that the links are only created if they point to a page different from the current, 
for example the 'previous' link will not be created on the first page.</p>

</body></html>