import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileNotifierProvider = FutureProvider.autoDispose<ProfileModel>((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getUserProfile();
});