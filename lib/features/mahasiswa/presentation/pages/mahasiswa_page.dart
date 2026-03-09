import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: $error',
          onRetry: () => ref.invalidate(mahasiswaNotifierProvider),
        ),
        data: (listMahasiswa) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
            child: GridView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: listMahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = listMahasiswa[index];
                final color = AppConstants.dashboardGradients[
                index % AppConstants.dashboardGradients.length][0];

                return MahasiswaGridCard(mahasiswa: mhs, cardColor: color);
              },
            ),
          );
        },
      ),
    );
  }
}