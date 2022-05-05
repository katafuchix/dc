<!--ヘッダー-->
{include file="user/header.tpl"}

<!--タイトル-->
{html_style type="title" title="あしあと" bgcolor=$title_bgcolor fontcolor=$title_fontcolor}
あなたのﾌﾟﾛﾌｨｰﾙﾍﾟｰｼﾞを訪れたﾕｰｻﾞを表示します｡<br>
<!--コンテンツ開始-->
<div align="left" style="text-align:left;font-size:small;">
	{foreach from=$app.listview_data item=item}
	<span style="color:#009900">{$item.footprint_regist_time|jp_date_format:"%m/%d(%a) %H:%M"}</span><br />
	&nbsp;&nbsp;<a href="?action_user_profile_view=true&user_id={$item.user_id}">{$item.user_nickname}</a>さん<br />
	{/foreach}
</div>

{include file="user/pager.tpl"}
<!--コンテンツ終了-->

<!--フッター-->
{include file="user/footer.tpl"}
