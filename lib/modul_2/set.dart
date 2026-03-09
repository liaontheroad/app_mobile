import 'dart:io';

void main() {
  Set<String> dataSet = {'a', 'b', 'c', 'd', 'e'};

  print('SEMUA DATA');
  int counter = 1;
  for (String data in dataSet) {
    print('$counter. $data');
    counter++;
  }

  print('Total data: ${dataSet.length}');

  stdout.write('\nMasukkan data baru: ');
  String newData = stdin.readLineSync()!;
  if (dataSet.add(newData)) {
    print('Data "$newData" berhasil ditambahkan!');
  } else {
    print('Data "$newData" gagal ditambahkan karena sudah ada (Duplicate)!');
  }

  stdout.write('Masukkan data yang ingin dihapus: ');
  String hapusData = stdin.readLineSync()!;
  if (dataSet.remove(hapusData)) {
    print('Data "$hapusData" berhasil dihapus!');
  } else {
    print('Data "$hapusData" tidak ditemukan.');
  }

  stdout.write('Masukkan data yang ingin dicek: ');
  String cekData = stdin.readLineSync()!;
  if (dataSet.contains(cekData)) {
    print('Data "$cekData" ada di Set!');
  } else {
    print('Data "$cekData" tidak ada di Set!');
  }
}