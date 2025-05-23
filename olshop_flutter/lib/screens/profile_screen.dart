import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  void _confirmLogout(BuildContext context, UserProvider userProvider) {
    final blue = Colors.blue.shade700;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirm Logout',
          style: TextStyle(color: blue, fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: TextStyle(color: blue)),
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

  @override
  Widget build(BuildContext context) {
    final blue = Colors.blue.shade700;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: blue,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              return IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: userProvider.user == null
                    ? null
                    : () => _confirmLogout(context, userProvider),
                color: Colors.white,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            final user = userProvider.user;
            if (user == null) {
              return Center(
                child: Text(
                  'No user logged in',
                  style: TextStyle(fontSize: 18, color: blue.withOpacity(0.6)),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: blue.withOpacity(0.1),
                    backgroundImage: AssetImage(user.imagePath),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    user.username,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 18,
                      color: blue.withOpacity(0.75),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout_outlined),
                      label: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor: blue.withOpacity(0.4),
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
