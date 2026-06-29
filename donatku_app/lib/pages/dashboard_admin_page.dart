import 'package:flutter/material.dart';
import 'login_page.dart';
import 'produk_page.dart';
import 'pesanan_page.dart';

class DashboardAdminPage extends StatelessWidget {
  const DashboardAdminPage({super.key});

  Widget menuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.pink, size: 35),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Khusus admin'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }

  void logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.admin_panel_settings, size: 90, color: Colors.pink),
            const Text(
              'Admin DonatKu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Mengelola produk dan semua pesanan'),
            const SizedBox(height: 30),
            menuCard(
              context,
              'Kelola Produk Donat',
              Icons.donut_large,
              const ProdukPage(),
            ),
            menuCard(
              context,
              'Lihat Semua Pesanan',
              Icons.receipt_long,
              const PesananPage(isAdmin: true),
            ),
          ],
        ),
      ),
    );
  }
}