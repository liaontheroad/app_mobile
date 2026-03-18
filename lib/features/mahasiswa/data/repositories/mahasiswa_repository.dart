import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final Dio _dio = Dio();

  final _headers = {
    'Accept': 'application/json',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
  };

  Future<List<MahasiswaModel>> getAllMahasiswa() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/comments',
        options: Options(headers: _headers),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.take(20).map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data mahasiswa');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<List<MahasiswaModel>> getMahasiswaAktif() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
        options: Options(headers: _headers),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.take(10).map((json) => MahasiswaModel(
          nama: json['title'] ?? 'Tanpa Judul',
          email: json['body'] ?? 'Tidak ada deskripsi',
          nim: json['id'].toString(),
          jurusan: 'Mahasiswa Aktif (API)',
          isAktif: true,
        )).toList();
      } else {
        throw Exception('Gagal memuat data mahasiswa aktif');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}