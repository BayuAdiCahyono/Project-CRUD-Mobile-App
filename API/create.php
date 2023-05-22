<?php

$conn = new mysqli("localhost","root","","crudflutter");
$code = $_POST["code"];
$nama = $_POST["nama"];
$harga = $_POST["harga"];
$data = mysqli_query($conn, "insert into produk set code='$code', nama='$nama', harga='$harga' ");

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