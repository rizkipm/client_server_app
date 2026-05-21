import 'package:client_server_app/models/model_get_mahasiswa.dart';
import 'package:client_server_app/providers/mahasiswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormTambahData extends StatefulWidget {

  final ModelGetMahasiswa? mahasiswa; // Tambahkan parameter mahasiswa untuk mengubah data
  const FormTambahData({super.key, required this.mahasiswa});

  @override
  State<FormTambahData> createState() => _FormTambahDataState();
}

class _FormTambahDataState extends State<FormTambahData> {

  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //jika mode edit, isi textfield dengan data yang mau di ubah
    if (widget.mahasiswa != null) {
      _nimController.text = widget.mahasiswa!.nim;
      _namaController.text = widget.mahasiswa!.nama;
      _jurusanController.text = widget.mahasiswa!.jurusan;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nimController.dispose();
    _namaController.dispose();
    _jurusanController.dispose();
  }

  void _simpanData() async{
    if(_formKey.currentState!.validate()){
      final provider = context.read<MahasiswaProvider>();
      bool berhasil = false;

      if(widget.mahasiswa == null){
        //jalankan aksi tambah data
        berhasil = await provider.createMahasiswa(
          _nimController.text,
          _namaController.text,
          _jurusanController.text,
        );
      }else{
        //jalankan aksi ubah data
        berhasil = await provider.ubahDataMahasiswa(
          widget.mahasiswa!.id,
          _nimController.text,
          _namaController.text,
          _jurusanController.text,
        );
      }

      if(berhasil && mounted){
        Navigator.pop(context);//kembali ke halama utama jika berhasil
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Form Mahasiswa'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                    }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _jurusanController,
                decoration: const InputDecoration(
                  labelText: 'Jurusan',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jurusan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 10,),
              ElevatedButton(onPressed: _simpanData, child: Text('Simpan Data'),
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              
              )
            ]
        ),
      )

    ));
  }
}
