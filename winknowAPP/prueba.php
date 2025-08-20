<?php
    $user_var = "usuarioJuancito";
    $admin_var = "admin";
    $privilegio = true;

    if ($privilegio) {
        echo "<p style='color:red; background-color:black; border-radius:20px; padding:10px; font-family:arial; font-size:50PX; width:fit-content; margin:10px; display:flex;'>sos : " . $user_var . "</p>";
    } else {
        echo "sos " . $admin_var;
    }
?>