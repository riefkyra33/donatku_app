# DonatKu App

DonatKu App adalah aplikasi pemesanan donat berbasis Flutter. Aplikasi ini dibuat untuk memudahkan pengguna dalam melihat daftar produk donat, melakukan pemesanan, serta mengelola data secara sederhana. Sistem penyimpanan data pada aplikasi ini sudah menggunakan **database lokal SQLite**, sehingga aplikasi dapat berjalan tanpa koneksi internet, tanpa XAMPP, dan tanpa server API.

## Fitur Aplikasi

* Login pengguna
* Register akun baru
* Akun admin default
* Menampilkan daftar produk donat
* Melakukan pemesanan donat
* Menyimpan data user, produk, dan pesanan ke database lokal
* CRUD data menggunakan SQLite
* Tidak membutuhkan koneksi internet untuk menjalankan aplikasi

## Teknologi yang Digunakan

* Flutter
* Dart
* SQLite
* Package `sqflite`
* Package `path`

## Database Lokal

Aplikasi ini menggunakan database lokal SQLite. Artinya, data aplikasi disimpan langsung di perangkat pengguna. Sebelumnya aplikasi masih menggunakan API atau database server, tetapi sekarang sudah diubah menjadi penyimpanan lokal agar lebih mudah dijalankan.

Keuntungan menggunakan database lokal:

1. Aplikasi bisa berjalan tanpa internet.
2. Tidak perlu menjalankan XAMPP.
3. Tidak bergantung pada IP laptop atau jaringan.
4. Proses akses data lebih cepat.
5. Cocok untuk aplikasi CRUD sederhana.

Kekurangannya, data hanya tersimpan di perangkat tersebut. Jika aplikasi dihapus, maka data lokal juga dapat ikut terhapus.

## Struktur Folder Penting

```text
lib/
├── main.dart
├── pages/
│   ├── login_page.dart
│   ├── register_page.dart
│   └── halaman lainnya
├── services/
│   └── api_service.dart
└── db_helper.dart
```

Keterangan:

```text
main.dart        = File utama aplikasi Flutter
db_helper.dart   = File pengelola database lokal SQLite
api_service.dart = Service aplikasi yang sudah diarahkan ke database lokal
pages/           = Folder halaman tampilan aplikasi
```

## Akun Admin Default

Gunakan akun berikut untuk login sebagai admin:

```text
Email    : admin@gmail.com
Password : admin123
```

## Cara Menjalankan Project

Pastikan Flutter sudah terinstall di laptop atau komputer.

1. Clone atau download project ini.

```bash
git clone https://github.com/username/donatku_app.git
```

2. Masuk ke folder project.

```bash
cd donatku_app
```

3. Install dependency Flutter.

```bash
flutter pub get
```

4. Jalankan aplikasi.

```bash
flutter run
```

## Dependency yang Dibutuhkan

Pastikan file `pubspec.yaml` memiliki dependency berikut:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.2
  path: ^1.9.0
```

Setelah menambahkan dependency, jalankan:

```bash
flutter pub get
```

## Cara Reset Database Lokal

Jika data lama masih muncul atau aplikasi error karena database lama, lakukan langkah berikut:

1. Uninstall aplikasi dari HP.
2. Jalankan perintah berikut di terminal:

```bash
flutter clean
flutter pub get
flutter run
```

Dengan cara ini, database lokal akan dibuat ulang dari awal.

## Alur Aplikasi

```text
Register → Data user disimpan ke SQLite
Login → Data dicek dari SQLite
Dashboard → Menampilkan produk donat
Pemesanan → Data pesanan disimpan ke SQLite
```

## Penjelasan Singkat Project

DonatKu App merupakan aplikasi pemesanan donat sederhana yang dibuat menggunakan Flutter. Aplikasi ini menerapkan konsep CRUD dan penyimpanan data lokal menggunakan SQLite. Dengan database lokal, aplikasi dapat berjalan secara mandiri tanpa membutuhkan koneksi ke server. Hal ini membuat aplikasi lebih mudah dijalankan saat demo, praktikum, atau presentasi tugas kuliah.

## Pengembangan Selanjutnya

Beberapa fitur yang dapat dikembangkan ke depannya:

* Menambahkan laporan transaksi
* Menambahkan fitur cetak struk
* Menambahkan manajemen stok produk
* Menambahkan upload gambar produk
* Menambahkan sinkronisasi database lokal ke server online
* Menambahkan role admin dan user secara lebih lengkap

## Pembuat

Nama Project: DonatKu App
Dibuat untuk: Tugas aplikasi mobile berbasis Flutter
Database: SQLite lokal
Framework: Flutter
