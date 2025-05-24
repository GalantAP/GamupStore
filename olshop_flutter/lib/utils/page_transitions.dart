import 'package:flutter/material.dart';

class PageTransitions {
  /// Membuat animasi transisi halaman berupa kombinasi fade dan slide dari kanan ke kiri.
  /// 
  /// [page] adalah widget halaman tujuan yang ingin ditransisikan.
  /// Mengembalikan objek [Route] dengan animasi custom yang dapat digunakan pada Navigator.
  static Route<T> fadeSlideFromRight<T>(Widget page) {
    return PageRouteBuilder<T>(
      // Membangun halaman yang akan ditampilkan
      pageBuilder: (context, animation, secondaryAnimation) => page,

      // Durasi animasi transisi
      transitionDuration: const Duration(milliseconds: 400),

      // Builder untuk animasi transisi yang melibatkan efek fade dan slide
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Animasi opacity dari 0 (transparan) ke 1 (opaque) dengan curve easeInOut
        final Animation<double> fadeAnim = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );

        // Animasi posisi slide dari kanan layar (offset (1,0)) ke posisi asli (offset (0,0))
        final Animation<Offset> slideAnim = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );

        // Menggabungkan animasi fade dan slide pada widget child (halaman tujuan)
        return FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: child,
          ),
        );
      },
    );
  }
}
