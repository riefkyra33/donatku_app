import 'package:flutter/material.dart';
import 'login_page.dart';
import 'produk_member_page.dart';
import 'tambah_pesanan_page.dart';
import 'pesanan_page.dart';

class DashboardMemberPage extends StatelessWidget {
  final String namaMember;
  final String emailMember;

  const DashboardMemberPage({
    super.key,
    required this.namaMember,
    required this.emailMember,
  });

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
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
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
        title: const Text('Dashboard Member'),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.person,
              size: 90,
              color: Colors.pink,
            ),
            Text(
              'Halo, $namaMember',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              emailMember,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            menuCard(
              context,
              'Lihat Menu Donat',
              Icons.donut_large,
              const ProdukMemberPage(),
            ),
            menuCard(
              context,
              'Buat Pesanan',
              Icons.shopping_cart,
              TambahPesananPage(
                namaMember: namaMember,
                emailMember: emailMember,
              ),
            ),
            menuCard(
              context,
              'Riwayat Pesanan Saya',
              Icons.history,
              PesananPage(
                isAdmin: false,
                emailMember: emailMember,
              ),
            ),
          ],
        ),
      ),
    );
  }
}