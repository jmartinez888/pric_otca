<?php
/* BasicPagination.class.php 
   Generic class for pagination, PHP4 and PHP5 compatible

Author: Roger Baklund <roger@baklund.no>
License: LGPL
Version: 1.0 rb09122012

*/

class BasicPagination {
  function BasicPagination($max,$baseurl='?',$itemcount=10,$offset_param_name='offset',$sticky=true) {
    $this->max = $max;
    $this->baseurl = $baseurl;
    $this->itemcount = $itemcount;
    $this->offset_param_name = $offset_param_name;
    $this->offset = isset($_REQUEST[$offset_param_name]) ? (int) $_REQUEST[$offset_param_name] : 0;
    $this->sticky = $sticky;
    $this->unstick = array();
    $this->link_class = '';
    $this->anchor = '';
  }
  function UnStick($ParamName) { 
    $this->unstick[] = $ParamName;
  } 
  function Label($page) {               # override
    return $page;    # 1 based page number
  } 
  function Translate($str) {         # override
    if(function_exists('translate')) 
      $str = translate($str);
    return $str;
  }
  function PagesHTML($MaxPageLinks=20,$sep='&nbsp;',$Elip='...') {
    return $this->firstpage().$sep.$this->previouspage().$sep.
           $this->pagelinks($MaxPageLinks,$sep,$Elip).$sep.
           $this->nextpage().$sep.$this->lastpage();
  }
  # lower level methods below
  function pagelinks($MaxPageLinks=20,$sep='&nbsp;',$Elip='...') {
    $pages = array();
    for($i=1;$i<=ceil($this->max/$this->itemcount);$i++)
      $pages[] = $this->pagelink($i,$this->Label($i));
    if($MaxPageLinks < 8) $MaxPageLinks = 8; # minimum 8
    $MaxPageLinks += $MaxPageLinks%2;  # must be even
    $MaxPageLinks += $MaxPageLinks%4;  # must be dividable by 4
    $_half = $MaxPageLinks / 2;
    $_quart = $_half / 2;
    $currentpage = 1+floor($this->offset/$this->itemcount);
    if(count($pages) > $MaxPageLinks) {
      $ELIP = array($Elip);
      if(($currentpage < $_half) or 
         ($currentpage > count($pages)-$_half+1)) {
        $firstPart = array_slice($pages,0,$_half);
        $lastPart = array_slice($pages,-$_half); 
        $pages = array_merge($firstPart,$ELIP,$lastPart);
      } else {
        $firstPart = array_slice($pages,0,$_quart);
        $lastPart = array_slice($pages,-$_quart);
        $middlePart = array_slice($pages,$currentpage-$_quart,$_half-1);
        if($currentpage == $_half)
          $pages = array_merge($firstPart,$middlePart,$ELIP,$lastPart);
        elseif($currentpage == count($pages)-$_half+1)
          $pages = array_merge($firstPart,$ELIP,$middlePart,$lastPart);
        else
          $pages = array_merge($firstPart,$ELIP,$middlePart,$ELIP,$lastPart);
      }
    }
    $pages = implode($sep,$pages);
    return $pages;
  }
  function make_URL($offset) {
    $sticky = '';
    if($this->sticky) {
      $a = $_REQUEST;  # copy URL parameters
      unset($a[$this->offset_param_name]);
      foreach($this->unstick as $parameter_name) 
        unset($a[$parameter_name]);
      foreach($a as $k=>$v)
        $sticky.='&amp;'.$k.'='.urlencode($v);
    }
    return $this->baseurl.
           ((substr($this->baseurl,-1,1) == '?') ? '':'&amp;').
           $this->offset_param_name.'='.$offset.$sticky.
           ($this->anchor?'#'.$this->anchor:'');
  }
  function pagelink($page,$Label=false) {
    if($Label) 
      $Label = $this->Translate($Label);
    $offset = ($page-1) * $this->itemcount;
    return ($offset==$this->offset) ? ($Label?$Label:$page) : 
      '<a href="'.$this->make_URL($offset).'"'.
        ($this->link_class ? ' class="'.$this->link_class.'"':'').'>'.
        ($Label?$Label:$page).'</a>';
  }
  function firstpage($str='First') { 
    return $this->pagelink(1,$str); 
  }
  function lastpage($str='Last') { 
    return $this->pagelink(ceil($this->max/$this->itemcount),$str); 
  }
  function nextpage($str='Next') { 
    $str = $this->Translate($str);
    return (($this->offset+$this->itemcount) < $this->max) ?
      '<a href="'.$this->make_URL($this->offset + $this->itemcount).'"'.
      ($this->link_class ? ' class="'.$this->link_class.'"':'').
      '>'.$str.'</a>' : $str;
  }  
  function previouspage($str='Prev') {
    $str = $this->Translate($str);
    return $this->offset ? 
      '<a href="'.$this->make_URL(($this->offset >= $this->itemcount) ?
      ($this->offset - $this->itemcount):0).'"'.
      ($this->link_class ? ' class="'.$this->link_class.'"':'').
      '>'.$str.'</a>' : $str;
  }
}

?>