import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final mahasiswaNotifierProvider = FutureProvider.autoDispose<List<MahasiswaModel>>((ref) async {
  final repo = ref.watch(mahasiswaRepositoryProvider);
  return repo.getAllMahasiswa();
});

final mahasiswaAktifNotifierProvider = FutureProvider.autoDispose<List<MahasiswaModel>>((ref) async {
  final repo = ref.watch(mahasiswaRepositoryProvider);
  return repo.getMahasiswaAktif();
});