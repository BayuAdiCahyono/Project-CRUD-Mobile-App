import 'dart:convert';
import 'dart:async';

import 'package:crud_bayuadi/adddata.dart';
import 'package:crud_bayuadi/editdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  List _listdata = [];
  bool _isloading = true;
  Future _getdata() async {
    try {
      final respone =
          await http.get(Uri.parse('http://192.168.206.24/crudsql/read.php'));
      if (respone.statusCode == 200) {
        print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respone = await http.post(
        Uri.parse('http://192.168.206.24/crudsql/delete.php'),
        body: {
          "code": id,
        },
      );
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    //print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => EditData(
                          ListData: {
                            "id": _listdata[index]['id'],
                            "code": _listdata[index]['code'],
                            "nama": _listdata[index]['nama'],
                            "harga": _listdata[index]['harga'],
                          },
                        )),
                  ),
                );
              },
              child: ListTile(
                title: Text(_listdata[index]['nama']),
                subtitle: Text(_listdata[index]['harga']),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            content: Text("Yakin Ingin Menghapus Data ?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    _hapus(_listdata[index]['code'])
                                        .then((value) {
                                      if (value) {
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              'Data Berhasil Di Hapus'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        final snackBar = SnackBar(
                                          content:
                                              const Text('Data Gagal Di Hapus'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomaPage()),
                                        (route) => false);
                                  },
                                  child: Text("Oke")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Batal"))
                            ],
                          );
                        }));
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 25),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => AddData())));
        },
      ),
    );
  }
}
