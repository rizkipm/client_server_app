import 'package:client_server_app/providers/mahasiswa_provider.dart';
import 'package:client_server_app/views/page_mahasiswa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MahasiswaProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PageMahasiswa(),
      debugShowCheckedModeBanner: false,
    ),

    );
  }
}


