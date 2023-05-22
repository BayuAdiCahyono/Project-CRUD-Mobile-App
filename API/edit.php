<?php

$conn = new mysqli("localhost","root","","crudflutter");
$id = $_POST["id"];
$code = $_POST["code"];
$nama = $_POST["nama"];
$harga = $_POST["harga"];
$data = mysqli_query($conn, "update produk set code='$code', nama='$nama', harga='$harga' where id='$id' ");

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