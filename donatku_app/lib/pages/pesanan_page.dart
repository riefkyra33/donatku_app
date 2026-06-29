import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class PesananPage extends StatefulWidget {
  final bool isAdmin;
  final String? emailMember;

  const PesananPage({
    super.key,
    required this.isAdmin,
    this.emailMember,
  });

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  List<Map<String, dynamic>> pesananList = [];

  @override
  void initState() {
    super.initState();
    loadPesanan();
  }

  Future<void> loadPesanan() async {
    final data = widget.isAdmin
        ? await DBHelper.getSemuaPesanan()
        : await DBHelper.getPesananByMember(widget.emailMember ?? '');

    setState(() {
      pesananList = data;
    });
  }

  Future<void> hapusPesanan(int id) async {
    await DBHelper.hapusPesanan(id);
    loadPesanan();
  }

  void konfirmasiHapus(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Pesanan'),
        content: const Text('Yakin ingin menghapus pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              hapusPesanan(id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isAdmin ? 'Semua Pesanan' : 'Riwayat Pesanan Saya';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: pesananList.isEmpty
          ? const Center(child: Text('Belum ada pesanan'))
          : ListView.builder(
              itemCount: pesananList.length,
              itemBuilder: (context, index) {
                final pesanan = pesananList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long, color: Colors.pink),
                    title: Text(pesanan['nama_pelanggan']),
                    subtitle: Text(
                      'Email: ${pesanan['email_member']}\n'
                      'Produk: ${pesanan['nama_produk']}\n'
                      'Jumlah: ${pesanan['jumlah']}\n'
                      'Total: Rp${pesanan['total_harga']}\n'
                      'Tanggal: ${pesanan['tanggal']}',
                    ),
                    isThreeLine: true,
                    trailing: widget.isAdmin
                        ? IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => konfirmasiHapus(pesanan['id']),
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}