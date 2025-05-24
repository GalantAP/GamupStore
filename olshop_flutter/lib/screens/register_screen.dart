import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart'; // Import Lottie

import '../providers/user_provider.dart';
import '../utils/page_transitions.dart'; // import helper animasi transisi
import 'login_screen.dart'; // agar bisa navigasi balik login

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorMessage;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _register() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final userId = DateTime.now().millisecondsSinceEpoch.toString();

    Provider.of<UserProvider>(context, listen: false).login(
      id: userId,
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.withAlpha((0.9 * 255).round()),
        content: Text(
          'Akun berhasil dibuat!',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    Navigator.of(context).pushReplacement(
      PageTransitions.fadeSlideFromRight(const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.indigo.shade900;
    final accentColor = Colors.indigo.shade700;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withAlpha((0.15 * 255).round()),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: Lottie.asset(
                            'assets/animation/Registrasi.json',
                            fit: BoxFit.contain,
                            repeat: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Buat Akun Baru',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: primaryColor.withAlpha((0.85 * 255).round()),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withAlpha((0.12 * 255).round()),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _usernameController,
                              label: 'Username',
                              icon: Icons.person_outline,
                              primaryColor: primaryColor,
                            ),
                            const SizedBox(height: 18),
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email_outlined,
                              inputType: TextInputType.emailAddress,
                              primaryColor: primaryColor,
                            ),
                            const SizedBox(height: 18),
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              icon: Icons.lock_outline,
                              obscure: true,
                              primaryColor: primaryColor,
                            ),
                            if (_errorMessage != null) ...[
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Icon(Icons.error_outline,
                                      color: Colors.red.shade700, size: 20),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 28),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _register,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  backgroundColor: primaryColor,
                                  elevation: 5,
                                  shadowColor: primaryColor.withAlpha((0.4 * 255).round()),
                                ),
                                child: Text(
                                  'Daftar Sekarang',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            PageTransitions.fadeSlideFromRight(const LoginScreen()),
                          );
                        },
                        child: Text(
                          "Sudah punya akun? Login",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: accentColor.withAlpha((0.85 * 255).round()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    bool obscure = false,
    required Color primaryColor,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor.withAlpha((0.8 * 255).round())),
        suffixIcon: obscure
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: primaryColor.withAlpha((0.8 * 255).round()),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor.withAlpha((0.4 * 255).round()), width: 1.3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor.withAlpha((0.3 * 255).round())),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        labelStyle: TextStyle(color: primaryColor.withAlpha((0.8 * 255).round())),
      ),
      obscureText: obscure ? !_isPasswordVisible : false,
      cursorColor: primaryColor,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan $label';
        }
        if (label == 'Email' && !value.contains('@')) {
          return 'Masukkan email valid';
        }
        if (label == 'Password' && value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }
}
