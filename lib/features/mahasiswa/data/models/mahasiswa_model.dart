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
  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['name'] ?? 'Tanpa Nama',
      email: json['email'] ?? 'Tidak ada email',
      nim: json['id'].toString(),
      jurusan: 'Komentator',
      isAktif: json['id'] % 2 == 0,
    );
  }
}