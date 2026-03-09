import 'dart:io';

void main() {
  List<String> datalist = [];
  print('Data list kosong: $datalist');

  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync();

    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0');
      }
    } catch (e) {
      print('Input tidak valid! Masukkan angka yang benar.');
    }
  }

  // Memasukkan data ke dalam List menggunakan for loop
  for (int i = 0; i < count; i++) {
    stdout.write('data ke-${i + 1}: ');
    String x = stdin.readLineSync()!;
    datalist.add(x);
  }

  // Menampilkan data List
  print('Data List:');
  print(datalist);

  print('\n--- TAMPIL DATA ---');
  stdout.write(
      'Masukkan index yang ingin ditampilkan (0 sampai ${datalist.length -
          1}): ');
  int indexTampil = int.parse(stdin.readLineSync()!);
  print('Data pada index $indexTampil adalah: ${datalist[indexTampil]}');

  print('\n--- UBAH DATA ---');
  stdout.write('Masukkan index yang ingin diubah: ');
  int indexUbah = int.parse(stdin.readLineSync()!);
  stdout.write('Masukkan data baru: ');
  String dataBaru = stdin.readLineSync()!;
  datalist[indexUbah] = dataBaru;
  print('Data berhasil diubah!');

  print('\n--- HAPUS DATA ---');
  stdout.write('Masukkan index yang ingin dihapus: ');
  int indexHapus = int.parse(stdin.readLineSync()!);
  datalist.removeAt(indexHapus);
  print('Data berhasil dihapus!');

  print('\n=== SEMUA DATA ===');
  for (int i = 0; i < datalist.length; i++) {
    print('Index $i: ${datalist[i]}');
  }
}