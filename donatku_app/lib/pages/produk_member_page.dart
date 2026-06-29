import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class ProdukMemberPage extends StatefulWidget {
  const ProdukMemberPage({super.key});

  @override
  State<ProdukMemberPage> createState() => _ProdukMemberPageState();
}

class _ProdukMemberPageState extends State<ProdukMemberPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Donat'),
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
                  ),
                );
              },
            ),
    );
  }
}