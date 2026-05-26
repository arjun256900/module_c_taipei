import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:module_c_taipei/welcome_screen.dart'; // Adjust path if needed

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// 1. ADD THE MIXIN: This is required for AnimationControllers
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<Alignment> _panAnimation;

  @override
  void initState() {
    super.initState();

    // 2. SETUP THE CONTROLLER (Duration dictates how fast it rolls)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ), // 2 seconds feels smooth and intentional
    );

    // 3. SETUP THE SLIDE (Starts 2.5x its own width to the left, ends at 0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-2.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // 4. SETUP THE ROTATION (Starts spun backward by 2 full circles, ends at 0)
    _rotateAnimation = Tween<double>(
      begin: -0.5,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _panAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // 5. LISTEN FOR COMPLETION TO AUTO-NAVIGATE
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToWelcome();
      }
    });

    // Start the animation!
    _controller.forward();
  }

  @override
  void dispose() {
    _controller
        .dispose(); // CRITICAL: Always dispose controllers to prevent memory leaks!
    super.dispose();
  }

  void _navigateToWelcome() {
    // PRO-TIP: Use Get.off() for Splash Screens so the user can't press the Android "Back" button to return to it!
    Get.off(() => const WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _panAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/image_1.jpg"),
              fit: BoxFit.cover,
              alignment: _panAnimation.value,
            ),
          ),
          child: child,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Stops the animation instantly and navigates
            _controller.stop();
            _navigateToWelcome();
          },
          backgroundColor: Colors.white,
          child: const Text(
            "Skip",
            style: TextStyle(
              color: Color.fromARGB(255, 135, 104, 10),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 6. WRAP THE LOGO IN THE TRANSITION WIDGETS
                  SlideTransition(
                    position: _slideAnimation,
                    child: RotationTransition(
                      turns: _rotateAnimation,
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 200,
                        width: 200,
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
