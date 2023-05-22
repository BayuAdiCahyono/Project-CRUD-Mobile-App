import 'package:crud_bayuadi/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  Future _simpan() async {
    final respone = await http
        .post(Uri.parse('http://192.168.206.24/crudsql/create.php'), body: {
      "code": code.text,
      "nama": nama.text,
      "harga": harga.text,
    });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Produk"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: code,
                decoration: InputDecoration(
                  hintText: "code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Code Harus Di Isi !!!";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: "nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama Harus Di Isi !!!";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: harga,
                decoration: InputDecoration(
                  hintText: "harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harga Harus Di Isi !!!";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Data Berhasil Di Simpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Data Gagal Di Simpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomaPage()),
                        (route) => false);
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
