import 'package:flutter/material.dart';
// FIX 1: We use 'hide AuthProvider' to stop the conflict with Firebase's class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Import your screens
import 'package:maplotai_task/screens/BottomNavigate.dart';
import 'package:maplotai_task/screens/LoginScreen.dart';

// FIX 2: Ensure this path matches your folder exactly
import 'package:maplotai_task/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authprovider()),
      ],
      child: MaterialApp(
        title: 'Student Check-In',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData) {
              return const BottomNavigate();
            }
            return const Loginscreen();
          },
        ),
      ),
    );
  }
}