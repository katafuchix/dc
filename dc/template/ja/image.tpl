<!--目永母□-->
{include file="header.tpl"}


<br>
<div align="center">
<font color="#555">▼</font>§<font color="#555">§</font>§<font color="#555">§</font>§<font color="#555">§</font>§<font color="#555">§</font><br>
{$app.title}<br>
〃<font color="#555">〃</font>〃<font color="#555">〃</font>〃<font color="#555">〃</font>〃<font color="#555">〃</font>▼<br>
</div>
<br>
{foreach from=$app_ne.image_list item=item key =k}
{if $item.title != ''}
見角<br>
谷<a href="{$item.url}">{$item.title}</a><br>
<hr color="#555" width="60%" size="2" align="left">
{/if}
{/foreach}

{if $app.idol_name}
見角<br>
谷<a href="http://mobile.dmm.com/monthly/idol/monthly_index.php?&affiliate_id=modemode-001">{$app.idol_name}毛手勻午葦月〞<br>
{/if}

<hr color="#555" width="60%" size="2" align="left">

<!--白永正□-->
{include file="footer.tpl"}
