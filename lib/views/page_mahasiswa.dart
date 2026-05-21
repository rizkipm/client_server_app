import 'package:client_server_app/providers/mahasiswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form_tambah_data.dart';

class PageMahasiswa extends StatefulWidget {
  const PageMahasiswa({super.key});

  @override
  State<PageMahasiswa> createState() => _PageMahasiswaState();
}

class _PageMahasiswaState extends State<PageMahasiswa> {

  //ambil data dari dataabase saat halaman pertama kali dibuka
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(()=> context.read<MahasiswaProvider>().getDataMahasiswa());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Data Mahasiswa'),
      ),

      body: Consumer<MahasiswaProvider>(
        builder: (context, provider, child){
          if(provider.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(provider.daftarMahasiswa.isEmpty){
            return const Center(
              child: Text('Tidak ada data mahasiswa'),
            );
          }
          return ListView.builder(
            itemCount: provider.daftarMahasiswa.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index){
              final mahasiswa = provider.daftarMahasiswa[index];
              return Card(
                child: ListTile(
                  title: Text(mahasiswa.nama),
                  subtitle: Text(mahasiswa.nim),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //tombol edit
                      IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FormTambahData(mahasiswa: mahasiswa,)));
                        },
                        icon: Icon(Icons.edit),

                      ),
                      //tombol hapus
                      IconButton(onPressed: (){
                        provider.hapusDataMahasiswa(mahasiswa.id);
                      }, icon: Icon(Icons.delete), color: Colors.red,)
                    ],
                  ),
                ),
              );

            });
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> FormTambahData(mahasiswa: null,)));
      }, child: Icon(Icons.add, color: Colors.deepPurple,),),
    );
  }
}
