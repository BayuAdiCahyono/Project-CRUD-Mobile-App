<?php

$conn = new mysqli("localhost","root","","crudflutter");
$code = $_POST["code"];
$data = mysqli_query($conn, "delete from produk where code='$code' ");

if ($data) {
    echo json_encode([
        'pesan' => 'Berhasil'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}

?>