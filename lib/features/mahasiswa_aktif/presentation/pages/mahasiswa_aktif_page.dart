import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../mahasiswa/presentation/providers/mahasiswa_provider.dart';
import '../../../mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaAktifState = ref.watch(mahasiswaAktifProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifProvider),
          ),
        ],
      ),
      body: mahasiswaAktifState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: $error',
          onRetry: () => ref.invalidate(mahasiswaAktifProvider),
        ),
        data: (listMahasiswaAktif) {
          if (listMahasiswaAktif.isEmpty) {
            return const Center(child: Text('Belum ada mahasiswa yang aktif.'));
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaAktifProvider),
            child: GridView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: listMahasiswaAktif.length,
              itemBuilder: (context, index) {
                final mhs = listMahasiswaAktif[index];
                final color = AppConstants.gradientPink[0];

                return MahasiswaGridCard(mahasiswa: mhs, cardColor: color);
              },
            ),
          );
        },
      ),
    );
  }
}