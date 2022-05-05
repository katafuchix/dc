<!-- ここからページャ -->
{if $app.pager.hasprev}
	<a href="{$app.pager.link}&start=0">★</a>&nbsp;<a href="{$app.pager.link}&start={$app.pager.prev}">&lt;&lt;</a>
{else}
	&nbsp;&lt;&lt;
{/if}
{foreach from=$app.pager.pager item=page}
	{if $page.offset == $app.pager.current}
	<strong>{$page.index}</strong>
	{else}
	<a href="{$app.pager.link}&start={$page.offset}">{$page.index}</a>
	{/if}
	&nbsp;
{/foreach}
	{if $app.pager.hasnext}
	<a href="{$app.pager.link}&start={$app.pager.next}">&gt;&gt;</a>
	&nbsp;<a href="{$app.pager.link}&start={$app.pager.last}">★</a>
	{else}
	&gt;&gt;&nbsp;
{/if}
<!-- ここまでページャ -->
