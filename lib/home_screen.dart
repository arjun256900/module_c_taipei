import 'package:flutter/material.dart';
import 'package:module_c_taipei/views/discover_view.dart';
import 'package:module_c_taipei/views/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [DiscoverView(), HomeView()];
  int activeIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: .all(20), child: screens[activeIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: activeIndex,
        onTap: (value) {
          setState(() {
            activeIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: "Discover",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
    );
  }
}
