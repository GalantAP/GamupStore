import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'login_screen.dart';
import 'EditProfilescreen.dart';
import 'WishlistScreen.dart';
import 'ChangePasswordScreen.dart';
import 'SettingsScreen.dart';
import 'order_history_screen.dart'; // Import halaman Order History

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Animasi transisi halaman dari kanan ke kiri
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // Konfirmasi logout dengan dialog
  void _confirmLogout(BuildContext context, UserProvider userProvider) {
    final primaryColor = Colors.indigo.shade700;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Confirm Logout',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: TextStyle(color: primaryColor)),
          ),
          TextButton(
            onPressed: () {
              userProvider.logout();
              Navigator.of(ctx).pop();
              Navigator.pushReplacement(
                context,
                _createRoute(const LoginScreen()),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  // Widget menu item dengan icon, judul, dan warna khusus (warna ikon disamakan dengan tema biru)
  Widget _buildModernMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final Color iconColor = Colors.indigo.shade700;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          splashColor: iconColor.withAlpha(60),
          highlightColor: iconColor.withAlpha(30),
          onTap: onTap,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: iconColor.withAlpha(40),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                letterSpacing: 0.3,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey.shade400,
            ),
            horizontalTitleGap: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.indigo.shade700;
    final backgroundColor = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 6,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            final user = userProvider.user;

            if (user == null) {
              return Center(
                child: Text(
                  'No user logged in',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor.withAlpha(153),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar user dengan shadow
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withAlpha(64),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: primaryColor.withAlpha(30),
                      backgroundImage: AssetImage(user.imagePath),
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Username
                  Text(
                    user.username,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor.darken(0.15),
                      letterSpacing: 1.1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Email
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 17,
                      color: primaryColor.withAlpha(178),
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 42),

                  // Menu items dengan animasi custom transisi
                  _buildModernMenuItem(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.of(context).push(_createRoute(const EditProfileScreen()));
                    },
                  ),

                  _buildModernMenuItem(
                    icon: Icons.history,
                    title: 'Order History',
                    onTap: () {
                      Navigator.of(context).push(_createRoute(const OrderHistoryScreen()));
                    },
                  ),

                  _buildModernMenuItem(
                    icon: Icons.favorite,
                    title: 'Wishlist',
                    onTap: () {
                      Navigator.of(context).push(_createRoute(const WishlistScreen()));
                    },
                  ),

                  _buildModernMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.of(context).push(_createRoute(const ChangePasswordScreen()));
                    },
                  ),

                  _buildModernMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.of(context).push(_createRoute(const SettingsScreen()));
                    },
                  ),

                  _buildModernMenuItem(
                    icon: Icons.info_outline,
                    title: 'About App',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'GamUp Store',
                        applicationVersion: '1.0.0',
                        applicationIcon: Icon(Icons.videogame_asset, color: primaryColor, size: 32),
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'A modern game store app built with Flutter. Get your favorite games here!',
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 50),

                  // Tombol logout dengan ikon putih dan warna biru tema
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout_outlined, size: 26, color: Colors.white),
                      label: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: primaryColor.withAlpha(150),
                      ),
                      onPressed: () => _confirmLogout(context, userProvider),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Extension untuk darken color
extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
