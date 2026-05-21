
import 'dart:convert';

List<ModelGetMahasiswa> modelGetMahasiswaFromJson(String str) => List<ModelGetMahasiswa>.from(json.decode(str).map((x) => ModelGetMahasiswa.fromJson(x)));

String modelGetMahasiswaToJson(List<ModelGetMahasiswa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGetMahasiswa {
  String id;
  String nim;
  String nama;
  String jurusan;

  ModelGetMahasiswa({
    required this.id,
    required this.nim,
    required this.nama,
    required this.jurusan,
  });

  factory ModelGetMahasiswa.fromJson(Map<String, dynamic> json) => ModelGetMahasiswa(
    id: json["id"],
    nim: json["nim"],
    nama: json["nama"],
    jurusan: json["jurusan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nim": nim,
    "nama": nama,
    "jurusan": jurusan,
  };
}
