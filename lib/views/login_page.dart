import 'package:final_adet/views/main_page.dart';
import 'package:final_adet/views/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  void _login() async {
    setState(() {
      _errorMessage = null; // Reset error message
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address.';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const mainPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'There is no email created with that.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Incorrect password. Please try again.';
        } else {
          _errorMessage = e.message; // Show general Firebase error
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Transform.scale(
                        scale: 3.0,
                        child: Image.asset(
                          'assets/logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Container(
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        margin: const EdgeInsets.only(top: 32.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 130, 35, 35),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              // Static Text for Email
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Email',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor : Colors.white,
                                  hintText: 'Email', // Set hint text for email
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16.0),
                              // Static Text for Password
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Password', // Set hint text for password
                                  prefixIcon: const Icon(Icons.fingerprint),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              if (_errorMessage != null) ...[
                                Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                              ],
                              ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  backgroundColor: Colors.black, // Set button background color to black
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white), // Set button text color to white
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignUpScreen()), // Navigate to Sign-Up page
                                  );
                                },
                                child: const Text(
                                  "Don't have an account? Sign up here",
                                  style: TextStyle(
                                    color: Colors.white,
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
              ],
            ),
          )
      )
    );
  }
}
