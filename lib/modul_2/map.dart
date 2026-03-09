import 'dart:io';

void main() {
  // === 1. INPUT DATA MAHASISWA (Single) ===
  print('INPUT DATA MAHASISWA');
  Map<String, String> mahasiswaSingle = {};

  stdout.write('Masukkan NIM: ');
  mahasiswaSingle['nim'] = stdin.readLineSync()!;

  stdout.write('Masukkan Nama: ');
  mahasiswaSingle['nama'] = stdin.readLineSync()!;

  stdout.write('Masukkan Jurusan: ');
  mahasiswaSingle['jurusan'] = stdin.readLineSync()!;

  stdout.write('Masukkan IPK: ');
  mahasiswaSingle['ipk'] = stdin.readLineSync()!;

  print('Data Mahasiswa: $mahasiswaSingle');


  // === 2. INPUT MULTIPLE MAHASISWA ===
  print('\nINPUT MULTIPLE MAHASISWA');
  stdout.write('Masukkan jumlah mahasiswa: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  List<Map<String, String>> listMahasiswa = [];

  for (int i = 1; i <= jumlah; i++) {
    print('Mahasiswa ke-$i');
    Map<String, String> mhs = {};

    stdout.write('Masukkan NIM: ');
    mhs['nim'] = stdin.readLineSync()!;

    stdout.write('Masukkan Nama: ');
    mhs['nama'] = stdin.readLineSync()!;

    stdout.write('Masukkan Jurusan: ');
    mhs['jurusan'] = stdin.readLineSync()!;

    stdout.write('Masukkan IPK: ');
    mhs['ipk'] = stdin.readLineSync()!;

    listMahasiswa.add(mhs);
  }
}