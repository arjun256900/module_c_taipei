import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:module_c_taipei/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Bouillabaisse.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SafeArea(
          child: Padding(
            padding: .all(30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                    ),
                    padding: .all(20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Please enter your account",
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.remove_red_eye_outlined),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Please enter your password",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  checked = !checked;
                                });
                              },
                              child: Icon(
                                checked
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: checked ? Colors.white : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "I have read and agreed User Privacy Policy",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 175,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(HomeScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                230,
                                186,
                                53,
                              ),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
