import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../data/models/mahasiswa_model.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
    final savedMahasiswa = ref.watch(savedMahasiswaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Mahasiswa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- KOTAK HIJAU: MAHASISWA TERSIMPAN ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.storage_rounded, size: 16),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Mahasiswa Tersimpan (Offline)',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    savedMahasiswa.maybeWhen(
                      data: (users) => users.isNotEmpty
                          ? TextButton.icon(
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).clearAllSaved();
                          ref.invalidate(savedMahasiswaProvider);
                        },
                        icon: const Icon(Icons.delete_sweep_outlined, size: 14, color: Colors.red),
                        label: const Text('Hapus Semua', style: TextStyle(fontSize: 12, color: Colors.red)),
                      )
                          : const SizedBox.shrink(),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ],
                ),
                savedMahasiswa.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (err, stack) => const Text('Error load data', style: TextStyle(color: Colors.red)),
                  data: (users) {
                    if (users.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                        child: const Text('Belum ada mahasiswa yang disimpan.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green.shade200)),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green.shade100),
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.green.shade100,
                              child: Text('${index + 1}', style: TextStyle(fontSize: 11, color: Colors.green.shade700)),
                            ),
                            title: Text(user['nama'] ?? '-'),
                            subtitle: Text('NIM: ${user['id']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, size: 16, color: Colors.red),
                              onPressed: () async {
                                await ref.read(mahasiswaNotifierProvider.notifier).removeMahasiswa(user['id'] ?? '');
                                ref.invalidate(savedMahasiswaProvider);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Daftar Mahasiswa API', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),

          // --- LIST MAHASISWA API DENGAN TOMBOL SAVE ---
          Expanded(
            child: mahasiswaState.when(
              loading: () => const LoadingWidget(),
              error: (err, stack) => CustomErrorWidget(message: 'Error: $err', onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh()),
              data: (mhsList) => ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                itemCount: mhsList.length,
                itemBuilder: (context, index) {
                  final mhs = mhsList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(mhs.nim)),
                      title: Text(mhs.nama, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(mhs.email, maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(Icons.save, size: 24, color: Colors.blue),
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).saveMahasiswa(mhs);
                          ref.invalidate(savedMahasiswaProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${mhs.nama} disimpan!')));
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}