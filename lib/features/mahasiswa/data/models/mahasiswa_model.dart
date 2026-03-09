class MahasiswaModel {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final bool isAktif;

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    this.isAktif = false,
  });
}