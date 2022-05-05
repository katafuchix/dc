<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
    </head>
    <body>
        <h1>Dc</h1>
        {form action="$script" ethna_action="anime_output"}
        
<br />
<br />  
        {form_name name="text"}<br />
        {form_input name="text"}

<br />
        {form_name name="x"}
        {form_input name="x"}
<br />
        {form_name name="y"}
        {form_input name="y" default="100"}
<br />
        {form_name name="size"}
        {form_input name="size" default="80"}
<br />                
        {form_input name="font"}
<br />
        {form_input name="color"}
<br />  
        {form_input name="image_file"}
        {form_input name="submit"}
        {/form}
        
        <br />
        <br />
    </body>
</html>
