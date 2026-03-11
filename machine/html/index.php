<?php
$flag_path = '/flags/flag1.txt';
$template_path = 'templates/flag.html';

// Si no tiene la cookie 'role', se la ponemos como 'user'
if (!isset($_COOKIE['role'])) {
    setcookie('role', 'user');
    $role = 'user';
} else {
    $role = $_COOKIE['role'];
}

// Comprobamos si ha hackeado la cookie
if ($role === 'admin') {
    $flag_content = file_exists($flag_path) ? trim(file_get_contents($flag_path)) : "Error de flag.";
    $html = file_get_contents($template_path);
    $html = str_replace('##FLAG##', htmlspecialchars($flag_content), $html);
    
    // Pista secreta para el puerto 1337 (Añadida al final del archivo)
    $pista = "\n" . "<" . "!-- ADMIN LOG: El servicio de diagnóstico en el puerto 1337 sigue activo. El PIN de hoy es 8492. --" . ">";
    echo $html . $pista;
} else {
    // Si no es admin, le denegamos el acceso
    $html = file_get_contents($template_path);
    $html = str_replace('##FLAG##', 'NO ERES ADMIN.', $html);
    $html = str_replace('ACCESO CONCEDIDO', 'ACCESO DENEGADO', $html);
    $html = str_replace('RETO SUPERADO', 'IDENTIDAD RECHAZADA', $html);
    echo $html;
}
?>