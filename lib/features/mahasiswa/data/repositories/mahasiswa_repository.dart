import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getAllMahasiswa() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulasi loading

    return [
      MahasiswaModel(nama: 'Annisa Putri', nim: '100526', jurusan: 'Teknik Informatika', email: 'annisaputri467904@gmail.com', isAktif: true),
      MahasiswaModel(nama: 'Aglaea Mnestia', nim: '100618', jurusan: 'Fashion Design', email: 'kalos618@gmail.com'),
      MahasiswaModel(nama: 'Anaxagoras Aletheia', nim: '100720', jurusan: 'Kimia', email: 'skemma720@gmail.com'),
      MahasiswaModel(nama: 'Castorice Aidonia', nim: '100216', jurusan: 'Fotografi', email: 'epieikeia216@gmail.com'),
      MahasiswaModel(nama: 'Cerydra Hyperborea', nim: '100514', jurusan: 'Hukum', email: 'hubris504@gmail.com'),
      MahasiswaModel(nama: 'Cipher Dolos', nim: '100945', jurusan: 'Teknologi Informasi', email: 'orexis945@gmail.com'),
      MahasiswaModel(nama: 'Cyrene Demiurge', nim: '100093', jurusan: 'Psikologi', email: 'philia093@gmail.com'),
      MahasiswaModel(nama: 'Hyacine Twilight', nim: '100252', jurusan: 'Kedokteran', email: 'eleos252@gmail.com'),
      MahasiswaModel(nama: 'Hysilens Styxia', nim: '100432', jurusan: 'Oseanografi', email: 'aporia432@gmail.com'),
      MahasiswaModel(nama: 'Mydeimos Kremnos', nim: '100600', jurusan: 'Sastra', email: 'polemos600@gmail.com'),
      MahasiswaModel(nama: 'Phainon Khaslana', nim: '100496', jurusan: 'Sastra', email: 'neikos496@gmail.com'),
      MahasiswaModel(nama: 'Tribbie Trianne Trinnon', nim: '100405', jurusan: 'Belum Ditentukan', email: 'haplotes405@gmail.com'),
      MahasiswaModel(nama: 'Amalia Citra', nim: '100365', jurusan: 'Arsitektur', email: 'skopeo365@gmail.com', isAktif: true),
    ];
  }

  Future<List<MahasiswaModel>> getMahasiswaAktif() async {
    final allData = await getAllMahasiswa();
    return allData.where((mhs) => mhs.isAktif).toList();
  }
}