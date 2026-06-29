import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'tambah_produk_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List<Map<String, dynamic>> produkList = [];

  @override
  void initState() {
    super.initState();
    loadProduk();
  }

  Future<void> loadProduk() async {
    final data = await DBHelper.getProduk();
    setState(() {
      produkList = data;
    });
  }

  Future<void> hapusProduk(int id) async {
    await DBHelper.hapusProduk(id);
    loadProduk();
  }

  void konfirmasiHapus(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Produk'),
        content: const Text('Yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              hapusProduk(id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk Donat'),
      ),
      body: produkList.isEmpty
          ? const Center(child: Text('Belum ada produk'))
          : ListView.builder(
              itemCount: produkList.length,
              itemBuilder: (context, index) {
                final produk = produkList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.donut_large, color: Colors.pink),
                    title: Text(produk['nama_produk']),
                    subtitle: Text(
                      'Harga: Rp${produk['harga']} | Stok: ${produk['stok']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TambahProdukPage(
                                  produk: produk,
                                ),
                              ),
                            );
                            loadProduk();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => konfirmasiHapus(produk['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahProdukPage()),
          );
          loadProduk();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}