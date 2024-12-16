import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/pet_list_screen.dart';
import './sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showSuccessAnimation = false;
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  bool _showShakeAnimation = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 20)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Trigger shake animation
  void _triggerShakeAnimation() {
    setState(() {
      _showShakeAnimation = true;
    });
    _animationController.forward().then((_) {
      _animationController.reverse().then((_) {
        setState(() {
          _showShakeAnimation = false;
        });
      });
    });
  }

  // Login function with animations
  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _triggerShakeAnimation();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        // Trigger success animation
        setState(() {
          _showSuccessAnimation = true;
        });

        // Delay for animation
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PetListScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _triggerShakeAnimation();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString().split("]")[1].trim()}')),
      );
    }
  }

  // Forgot password function
  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString().split("]")[1].trim()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  final offset = _showShakeAnimation ? _shakeAnimation.value : 0;
                  return Transform.translate(
                    offset: Offset(offset - offset / 2, 0),
                    child: child,
                  );
                },
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        SizedBox(height: 30),
                        _buildGradientTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                        ),
                        SizedBox(height: 16),
                        _buildGradientTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        SizedBox(height: 30),
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadowColor: Colors.teal.shade200,
                              elevation: 8,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: _resetPassword,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text(
                              'Don\'t have an account? Sign Up',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
          if (_showSuccessAnimation)
            Container(
              color: Colors.teal.withOpacity(0.8),
              child: Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGradientTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.teal.shade200, Colors.teal.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}


