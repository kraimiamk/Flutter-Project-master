import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import './conex/login_screen.dart';  // The login screen
import './screens/pet_list_screen.dart';  // The pet listing screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure bindings are initialized
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(), // Authentication check before showing the screen
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Checking if the user is already signed in
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // User is logged in, show PetListScreen
            return PetListScreen();
          } else {
            // User is not logged in, show LoginScreen
            return LoginScreen();
          }
        }
        // While checking the user's status, show a loading indicator
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}



