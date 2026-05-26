import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:module_c_taipei/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _startAnimation = true;
      });
    });
  }

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
        body: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: 60, vertical: 30),
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
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    padding: .all(20),
                    child: Column(
                      children: [
                        Text(
                          "Join us\nright now",
                          textAlign: .center,
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        AnimatedSlide(
                          offset: _startAnimation
                              ? Offset.zero
                              : Offset(0, 1.0),
                          duration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            width: 175,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(LoginScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                ),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  219,
                                  170,
                                  21,
                                ),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Login"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Expanded(child: Divider(color: Colors.white54)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "or",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.white54)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AnimatedSlide(
                          offset: _startAnimation
                              ? Offset.zero
                              : Offset(0, -1.0),
                          duration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            width: 175,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                ),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  219,
                                  170,
                                  21,
                                ),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Register"),
                            ),
                          ),
                        ),
                      ],
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
