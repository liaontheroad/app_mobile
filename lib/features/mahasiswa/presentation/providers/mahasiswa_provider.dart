import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final savedMahasiswaProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(localStorageProvider);
  return storage.getSavedMahasiswa();
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage) : super(const AsyncValue.loading()) {
    loadMahasiswa();
  }

  Future<void> loadMahasiswa() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getAllMahasiswa();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswa();
  }

  // --- Fungsi Save Mahasiswa ---
  Future<void> saveMahasiswa(MahasiswaModel mhs) async {
    await _storage.saveMahasiswaToLocal(id: mhs.nim, nama: mhs.nama);
  }

  Future<void> removeMahasiswa(String id) async {
    await _storage.removeSavedMahasiswa(id);
  }

  Future<void> clearAllSaved() async {
    await _storage.clearSavedMahasiswa();
  }
}

final mahasiswaAktifProvider = FutureProvider.autoDispose<List<MahasiswaModel>>((ref) async {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return repository.getMahasiswaAktif();
});

final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  return MahasiswaNotifier(
      ref.watch(mahasiswaRepositoryProvider),
      ref.watch(localStorageProvider)
  );

});