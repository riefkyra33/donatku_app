import '../database/db_helper.dart';

class ApiService {
  // Service ini sengaja dibuat tetap bernama ApiService agar halaman lama
  // seperti login_page.dart dan register_page.dart tidak perlu banyak diubah.
  // Semua proses di bawah ini sudah memakai database lokal SQLite melalui DBHelper.

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final user = await DBHelper.loginUser(email, password);

    if (user != null) {
      return {
        'success': true,
        'message': 'Login berhasil',
        'data': user,
      };
    }

    return {
      'success': false,
      'message': 'Email atau password salah',
      'data': null,
    };
  }

  static Future<Map<String, dynamic>> register(
    String nama,
    String email,
    String password,
  ) async {
    try {
      await DBHelper.registerUser(nama, email, password);

      return {
        'success': true,
        'message': 'Register berhasil. Silakan login.',
      };
    } catch (_) {
      return {
        'success': false,
        'message': 'Email sudah terdaftar',
      };
    }
  }

  static Future<List<dynamic>> getProduk() async {
    return await DBHelper.getProduk();
  }

  static Future<Map<String, dynamic>> tambahProduk(
    String namaProduk,
    String harga,
    String stok,
  ) async {
    final hargaInt = int.tryParse(harga) ?? 0;
    final stokInt = int.tryParse(stok) ?? 0;

    if (namaProduk.trim().isEmpty || hargaInt <= 0 || stokInt < 0) {
      return {
        'success': false,
        'message': 'Data produk tidak valid',
      };
    }

    await DBHelper.tambahProduk(namaProduk, hargaInt, stokInt);

    return {
      'success': true,
      'message': 'Produk berhasil ditambahkan',
    };
  }

  static Future<Map<String, dynamic>> editProduk(
    String id,
    String namaProduk,
    String harga,
    String stok,
  ) async {
    final idInt = int.tryParse(id) ?? 0;
    final hargaInt = int.tryParse(harga) ?? 0;
    final stokInt = int.tryParse(stok) ?? 0;

    if (idInt <= 0 || namaProduk.trim().isEmpty || hargaInt <= 0 || stokInt < 0) {
      return {
        'success': false,
        'message': 'Data produk tidak valid',
      };
    }

    await DBHelper.updateProduk(idInt, namaProduk, hargaInt, stokInt);

    return {
      'success': true,
      'message': 'Produk berhasil diubah',
    };
  }

  static Future<Map<String, dynamic>> hapusProduk(String id) async {
    final idInt = int.tryParse(id) ?? 0;

    if (idInt <= 0) {
      return {
        'success': false,
        'message': 'ID produk tidak valid',
      };
    }

    await DBHelper.hapusProduk(idInt);

    return {
      'success': true,
      'message': 'Produk berhasil dihapus',
    };
  }

  static Future<Map<String, dynamic>> tambahPesanan(
    String namaPelanggan,
    String emailMember,
    String namaProduk,
    String jumlah,
    String totalHarga,
  ) async {
    final jumlahInt = int.tryParse(jumlah) ?? 0;
    final totalHargaInt = int.tryParse(totalHarga) ?? 0;
    final tanggal = DateTime.now().toString().substring(0, 10);

    if (namaPelanggan.trim().isEmpty ||
        emailMember.trim().isEmpty ||
        namaProduk.trim().isEmpty ||
        jumlahInt <= 0 ||
        totalHargaInt <= 0) {
      return {
        'success': false,
        'message': 'Data pesanan tidak valid',
      };
    }

    await DBHelper.tambahPesanan(
      namaPelanggan,
      emailMember,
      namaProduk,
      jumlahInt,
      totalHargaInt,
      tanggal,
    );

    return {
      'success': true,
      'message': 'Pesanan berhasil dibuat',
    };
  }

  static Future<List<dynamic>> getSemuaPesanan() async {
    return await DBHelper.getSemuaPesanan();
  }

  static Future<List<dynamic>> getPesananMember(String emailMember) async {
    return await DBHelper.getPesananByMember(emailMember);
  }

  static Future<Map<String, dynamic>> hapusPesanan(String id) async {
    final idInt = int.tryParse(id) ?? 0;

    if (idInt <= 0) {
      return {
        'success': false,
        'message': 'ID pesanan tidak valid',
      };
    }

    await DBHelper.hapusPesanan(idInt);

    return {
      'success': true,
      'message': 'Pesanan berhasil dihapus',
    };
  }
}
