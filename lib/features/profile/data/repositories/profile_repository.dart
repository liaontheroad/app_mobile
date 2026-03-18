import '../models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return ProfileModel(
      nama: 'Annisa Putri',
      nim: '434241020',
      universitas: 'Universitas Airlangga',
      email: 'annisaputri467904@gmail.com',
      bio: 'If not today why tomorrow.',
      role: 'Developer',
    );
  }
}