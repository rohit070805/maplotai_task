import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

import '../utils/colors.dart';
import 'LoginScreen.dart';
import 'BottomNavigate.dart';
class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

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
                          "Sign Up",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 16),
                      controller: nameController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          hintText: "Name",
                          labelText: "Name",
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
                              "Already have a Account?",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Loginscreen()));
                                },
                                child: const Text(
                                  "Sign In!",
                                  style: TextStyle(fontSize: 18, color: Colors.blue),
                                ))
                          ],
                        ),


                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () async {
                                // 1. Input Validation
                                String name = nameController.text.trim();
                                String email = emailController.text.trim();
                                String password = passController.text.trim();

                                if (name.isEmpty || email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Please fill all fields"),
                                      backgroundColor: Colors.red));
                                  return;
                                }


                                String? error = await authProvider.signUp(email, password, name);

                                if (error == null) {

                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const BottomNavigate()));
                                  }
                                } else {

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(error), backgroundColor: Colors.red));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appColor,
                              ),
                              child: authProvider.isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
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