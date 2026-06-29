import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class TambahProdukPage extends StatefulWidget {
  final Map<String, dynamic>? produk;

  const TambahProdukPage({super.key, this.produk});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.produk != null) {
      namaController.text = widget.produk!['nama_produk'];
      hargaController.text = widget.produk!['harga'].toString();
      stokController.text = widget.produk!['stok'].toString();
    }
  }

  Future<void> simpanProduk() async {
    final nama = namaController.text.trim();
    final harga = int.tryParse(hargaController.text) ?? 0;
    final stok = int.tryParse(stokController.text) ?? 0;

    if (nama.isEmpty || harga <= 0 || stok < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data produk tidak valid')),
      );
      return;
    }

    if (widget.produk == null) {
      await DBHelper.tambahProduk(nama, harga, stok);
    } else {
      await DBHelper.updateProduk(
        widget.produk!['id'],
        nama,
        harga,
        stok,
      );
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.produk != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stok',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: simpanProduk,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(isEdit ? 'Update Produk' : 'Simpan Produk'),
            ),
          ],
        ),
      ),
    );
  }
}