<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
    </head>
    <body>
        <h1>Dc</h1>
        {form action="$script" ethna_action="output"}

        <!-- a href="?action_file=true&image_file={$app.image_file}&moji={$app.text}&font={$app.font}&x={$app.x}&y={$app.y}&color={$app.color}&size={$app.size}&flg=0" -->
        	<img src="?action_file=true&image_file={$app.image_file}&moji={$app.text}&font={$app.font}&x={$app.x}&y={$app.y}&color={$app.color}&size={$app.size}&flg=1" border="0">
        <!-- /a -->
<br />
<br />
        {form_name name="text"}<br />
        {form_input name="text"}
<br />
        {form_name name="x"}
        {form_input name="x"}
<br />
        {form_name name="y"}
        {form_input name="y"}
<br />
        {form_name name="size"}
        {form_input name="size"}
<br />                
        {form_input name="font"}
<br />
        {form_input name="color"}
<br />  
        {form_input name="submit"}
        
        {form_input name="image_file"}
        {/form}    
        
        <br />
        <br />
        </body>
</html>
