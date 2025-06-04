import 'package:flutter/material.dart';
import 'registrasi_screen.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'pesan_tiket_screen.dart';
import 'konfirmasi_pesanan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MuseumGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(), // Tampilkan SplashScreen pertama
      routes: {
        '/login_screen': (context) => LoginScreen(),
        '/registrasi_screen': (context) => RegistrasiScreen(),
        // Tambahkan rute lainnya sesuai kebutuhan
      },
    );
  }
}
