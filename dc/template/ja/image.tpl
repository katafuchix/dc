<!--�إå���-->
{include file="header.tpl"}


<br>
<div align="center">
<font color="#555">��</font>��<font color="#555">��</font>��<font color="#555">��</font>��<font color="#555">��</font>��<font color="#555">��</font><br>
{$app.title}<br>
��<font color="#555">��</font>��<font color="#555">��</font>��<font color="#555">��</font>��<font color="#555">��</font>��<br>
</div>
<br>
{foreach from=$app_ne.image_list item=item key =k}
{if $item.title != ''}
����<br>
��<a href="{$item.url}">{$item.title}</a><br>
<hr color="#555" width="60%" size="2" align="left">
{/if}
{/foreach}

{if $app.idol_name}
����<br>
��<a href="http://mobile.dmm.com/monthly/idol/monthly_index.php?&affiliate_id=modemode-001">{$app.idol_name}���äȸ��롪<br>
{/if}

<hr color="#555" width="60%" size="2" align="left">

<!--�եå���-->
{include file="footer.tpl"}
