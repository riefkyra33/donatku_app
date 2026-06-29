import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class TambahPesananPage extends StatefulWidget {
  final String namaMember;
  final String emailMember;

  const TambahPesananPage({
    super.key,
    required this.namaMember,
    required this.emailMember,
  });

  @override
  State<TambahPesananPage> createState() => _TambahPesananPageState();
}

class _TambahPesananPageState extends State<TambahPesananPage> {
  final jumlahController = TextEditingController();

  List<Map<String, dynamic>> produkList = [];
  int? selectedProdukId;
  Map<String, dynamic>? selectedProduk;

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

  void pilihProduk(int? id) {
    if (id == null) return;

    final produk = produkList.firstWhere(
      (item) => item['id'] == id,
    );

    setState(() {
      selectedProdukId = id;
      selectedProduk = produk;
    });
  }

  int hitungTotal() {
    if (selectedProduk == null) return 0;

    final jumlah = int.tryParse(jumlahController.text) ?? 0;
    final harga = selectedProduk!['harga'] as int;

    return harga * jumlah;
  }

  Future<void> simpanPesanan() async {
    if (selectedProduk == null || jumlahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk dan jumlah wajib diisi')),
      );
      return;
    }

    final jumlah = int.tryParse(jumlahController.text) ?? 0;
    final stok = selectedProduk!['stok'] as int;
    final harga = selectedProduk!['harga'] as int;

    if (jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah tidak valid')),
      );
      return;
    }

    if (jumlah > stok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stok tidak mencukupi')),
      );
      return;
    }

    final total = harga * jumlah;
    final tanggal = DateTime.now().toString().substring(0, 10);

    await DBHelper.tambahPesanan(
      widget.namaMember,
      widget.emailMember,
      selectedProduk!['nama_produk'].toString(),
      jumlah,
      total,
      tanggal,
    );

    await DBHelper.updateProduk(
      selectedProduk!['id'] as int,
      selectedProduk!['nama_produk'].toString(),
      harga,
      stok - jumlah,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pesanan berhasil dibuat')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final totalHarga = hitungTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: produkList.isEmpty
            ? const Center(
                child: Text('Belum ada produk tersedia'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Member: ${widget.namaMember}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Email: ${widget.emailMember}'),
                  const SizedBox(height: 24),

                  DropdownButtonFormField<int>(
                    value: selectedProdukId,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Pilih Menu Donat',
                      border: OutlineInputBorder(),
                    ),
                    items: produkList.map((produk) {
                      return DropdownMenuItem<int>(
                        value: produk['id'] as int,
                        child: Text(
                          '${produk['nama_produk']} - Rp${produk['harga']} - Stok ${produk['stok']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: pilihProduk,
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Beli',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Total Harga: Rp$totalHarga',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: simpanPesanan,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Simpan Pesanan'),
                  ),
                ],
              ),
      ),
    );
  }
} 