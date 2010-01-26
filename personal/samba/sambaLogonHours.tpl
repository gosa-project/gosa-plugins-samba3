{if $acl}
<!-- Javacript function used to switch a complete row or col of selected hours -->
<script language="javascript" type="text/javascript">
  {literal}
  var $regex = new Array();
  function toggle_chk($reg)
  {
    if(!$regex[$reg]){
      $regex[$reg] =1;
    }
    $regex[$reg] *= -1;
    if($regex[$reg] == 1){
      chk_set_all($reg,true);
    }else{
      chk_set_all($reg,false);
    }
  }
  {/literal}
</script>
{/if}

<h1>{t}Specify the hours this user is allowed to log in{/t}</h1>
<br>

<table cellspacing=0 cellpadding=0 style='border: solid 1px #B0B0B0; background-color: #EEEEEE; width :100%;' >
  <tr>
    <td>&nbsp;</td>
    <td colspan=24 style='text-align:center;height:24px;border-bottom: solid 1px #B0B0B0;'><b>{t}Hour{/t}</b></td>
  </tr>
  <tr>
    <td style='text-align: left;' class='list0'>&nbsp;</td>
    {foreach from=$Hours item=hours key=key_hours}
      {if (($hours)%2)==0}
        <td style="text-align:center;height: 22px; background-color: rgb(226, 226, 226); ">
      {else}
        <td style="text-align:center;height: 22px; background-color: rgb(245, 245, 245); border-right: solid 1px #B0B0B0;">
      {/if}
      {$hours}
    </td>
    {/foreach}
  </tr>

{if $acl}
  <!-- Add toggle buttons for hours -->
  <tr>
    <td style='text-align: left;' class='list0'>
      &nbsp;
    </td>
    {foreach from=$Hours item=hours key=key_hours}
      {if (($hours)%2)==0}
        <td style="text-align:center; height: 22px; background-color: rgb(226, 226, 226); text-align: right;">
      {else}
        <td style="text-align:center; height: 22px; background-color: rgb(245, 245, 245); border-right: solid 1px #B0B0B0; text-align: right;">
      {/if}

      <input type='button' onClick="toggle_chk('^day_[0-9]*_{$hours}$');" value='+/-' style='width:100%;'>
    </td>
    {/foreach}
    <td>
      <input type='button' onClick="toggle_chk('^day_[0-9]*_[0-9]*$');" value='+/-' style='width:100%;'>
    </td>
  </tr>
{/if}

  <!-- Add Entries -->
{foreach from=$Matrix item=days key=key_day}
  <tr>
    <td class='list0'>
      <b>{$Days[$key_day]}</b>
    </td>
    {foreach from=$days item=hours key=key_hour}
      {if (($key_hour)%2)==0}
        <td style="text-align:center;height: 22px; background-color: rgb(226, 226, 226); ">
      {else}
        <td style="text-align:center;height: 22px; background-color: rgb(245, 245, 245); border-right: solid 1px;">
      {/if}
          <input type='checkbox' 
            {if $acl} id='day_{$key_day}_{$key_hour}' name='day_{$key_day}_{$key_hour}' {/if}
            {if $Matrix[$key_day].$key_hour} checked  {/if}
            {if !$acl} disabled {/if}>
      </td>
    {/foreach}

{if $acl}
    <!-- Add toggle button for days -->
    <td>  
      <input type='button' onClick="toggle_chk('^day_{$key_day}_[0-9]*$')" value='+/-'  style='padding:0px;margin:0px;'>
    </td>
{/if}
  </tr>
{/foreach}
</table>
<br>
<input type='hidden' name='sambaLogonHoursPosted' value='1'> 
<br>
<p class="plugbottom">
{if $acl}
  <input type=submit name="save_logonHours" value="{msgPool type=saveButton}">
  &nbsp;
{/if}
  <input type=submit name="cancel_logonHours" value="{msgPool type=cancelButton}">
</p>

<!--  
// vim:tabstop=2:expandtab:shiftwidth=2:filetype=php:syntax:ruler: 
-->
