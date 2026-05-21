import 'dart:convert';
import 'package:client_server_app/models/model_get_mahasiswa.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MahasiswaProvider extends ChangeNotifier {
  //base url
  final String _baseUrl = 'http://192.168.1.5/crud_mahasiswa';

  List<ModelGetMahasiswa> _dataMahasiswa = [];
  bool _isLoading = false;

  List<ModelGetMahasiswa> get daftarMahasiswa => _dataMahasiswa;
  bool get isLoading => _isLoading;

  //READ: mengambil data dari api
  Future<void> getDataMahasiswa() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$_baseUrl/read.php'));
      if (response.statusCode == 200) {
        final List datasMahasiswa = json.decode(response.body);
        _dataMahasiswa = datasMahasiswa
            .map((e) => ModelGetMahasiswa.fromJson(e))
            .toList();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //CREATE: menambahkan data ke api
  Future<bool> createMahasiswa(String nim, String nama, String jurusan) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/create.php'),
        body: {'nim': nim, 'nama': nama, 'jurusan': jurusan},
      );
      if (response.statusCode == 200) {
        getDataMahasiswa();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> ubahDataMahasiswa(
    String id,
    String nim,
    String nama,
    String jurusan,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update.php'),
        body: {'id': id, 'nim': nim, 'nama': nama, 'jurusan': jurusan},
      );
      if (response.statusCode == 200) {
        getDataMahasiswa();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> hapusDataMahasiswa(String id) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/delete.php'),
        body: {'id': id},
      );
      if (response.statusCode == 200) {
        getDataMahasiswa();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
