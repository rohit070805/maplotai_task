import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Import Provider
import '../provider/auth_provider.dart';

import '../utils/colors.dart';
import 'SignUpScreen.dart';
import 'BottomNavigate.dart'; // 3. Import Dashboard to navigate after login

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // 4. Access the provider to check loading state
    final authProvider = Provider.of<Authprovider>(context);

    return Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              margin: EdgeInsets.only(
                  top: mediaquery.size.height * 0.3, left: 50, right: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 16),
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          hintText: "Email",
                          labelText: "Email",
                          labelStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                          hintStyle: const TextStyle(fontSize: 16),
                          fillColor: Colors.cyan.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: passController,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          hintText: "Password",
                          labelText: "Password",
                          labelStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                          hintStyle: const TextStyle(fontSize: 16),
                          fillColor: Colors.cyan.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Don't have a Account?",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Signupscreen()));
                                },
                                child: const Text(
                                  "Sign Up!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () async {
                                // 5. Input Validation
                                String email = emailController.text.trim();
                                String password = passController.text.trim();

                                if (email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Please fill all fields"),
                                          backgroundColor: Colors.red));
                                  return;
                                }

                                // 6. Call Sign In Function
                                String? error = await authProvider.signIn(
                                    email, password);

                                if (error == null) {
                                  // Success: Navigate to Dashboard
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const BottomNavigate()));
                                  }
                                } else {
                                  // Failure: Show Error Popup
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error),
                                            backgroundColor: Colors.red));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appColor,
                              ),
                              // 7. Show Loading Indicator or Arrow Icon
                              child: authProvider.isLoading
                                  ? const CircularProgressIndicator(
                                  color: Colors.white)
                                  : const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}