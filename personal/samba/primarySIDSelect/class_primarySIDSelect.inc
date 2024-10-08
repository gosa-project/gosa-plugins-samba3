<?php
/*
 * This code is part of GOsa (http://www.gosa-project.org)
 * Copyright (C) 2003-2008 GONICUS GmbH
 *
 * ID: $$Id: class_groupManagement.inc 14766 2009-11-05 14:30:35Z hickert $$
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

class primarySIDSelect extends management
{

  protected $skipFooter = TRUE;
  protected $skipHeader = TRUE;

  var $plHeadline = "Primary group selection";

  function __construct($config,$ui, $sid)
  {
    $this->config = $config;
    $this->ui = $ui;

    # Store the domain-sid in the session, to be able to use it in the filter.
    session::set("primarySIDSelect::sid", $sid);
    $this->storagePoints = array(get_ou("core", "groupRDN"));

    // Build filter
    if (session::global_is_set(get_class($this)."_filter")){
      $filter= session::global_get(get_class($this)."_filter");
    } else {
      $filter = new filter(get_template_path("sid-filter.xml", true, dirname(__FILE__)));
      $filter->setObjectStorage($this->storagePoints);
    }
    $this->setFilter($filter);

    // Build headpage
    $headpage = new listing(get_template_path("sid-list.xml", true, dirname(__FILE__)));
    $headpage->registerElementFilter("filterSID", "primarySIDSelect::filterSID");
    $headpage->setFilter($filter);
    parent::__construct($config, $ui, "groups", $headpage);
  }

  static function filterSID($row, $cn, $sid)
  {
    $cn= $cn[0];
    if(preg_match("/(512|513|514)$/", $sid[0])){
      return ("<b>{$cn}</b>"); 
    }
    return ("{$cn}"); 
  }
} 

?>
