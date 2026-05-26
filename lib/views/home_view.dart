import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:module_c_taipei/main_dish_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final images = [
    "assets/images/Boudin Noir.jpg",
    "assets/images/Bouillabaisse.jpg",
    "assets/images/Bloc de Foie Gras d’Oie.jpg",
  ];

  final foods = [
    {
      "name": "Matsutake foie gras",
      "description":
          "Matsutake and foie gras are mainly made from Matsutake and foie gras, with a rich and soft taste and a rich aroma.",
    },
    {
      "name": "Marseille fish soup",
      "description":
          "Marseille fish soup is a specialty dish in the southern French city of Marseille, featuring a rich flavor of tomatoes and fish.",
    },
    {
      "name": "French Snail",
      "description":
          "French snail is a traditional cuisine in France, mainly made from fresh snail meat and seasoned with rich herbs, garlic, and butter.",
    },
  ];

  List<dynamic> homeTypes = [];

  Timer? timer;
  final controller = PageController(initialPage: 0);
  final pageController = PageController(viewportFraction: 0.8);
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    loadFoods();
    Timer.periodic(const Duration(seconds: 3), (_) {
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> loadFoods() async {
    final resposne = await rootBundle.loadString("assets/food.json");
    final data = jsonDecode(resposne);
    setState(() {
      homeTypes = data;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned.fill(
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        activeIndex = value % 3;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(images[index % 3], fit: BoxFit.cover);
                    },
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        height: 15,
                        width: 15,
                        margin: .only(right: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeIndex == index
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.5),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(MainDishScreen(type: homeTypes[0]));
                },
                child: Container(
                  width: 120,
                  padding: .symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                    ],
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.dining_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                      const SizedBox(height: 15),
                      Text("Main dishes", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.to(MainDishScreen(type: homeTypes[1]));
                },
                child: Container(
                  width: 120,
                  padding: .symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                    ],
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.breakfast_dining_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                      const SizedBox(height: 15),
                      Text("Pastries", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.to(MainDishScreen(type: homeTypes[2]));
                },
                child: Container(
                  width: 120,
                  padding: .symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                    ],
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_drink_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                      const SizedBox(height: 15),
                      Text("Soups", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Popular food",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 550,
            child: PageView.builder(
              itemCount: 3,
              controller: pageController,
              itemBuilder: (context, index) {
                final food = foods[index];
                return AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    double pageOffset = 0.0;
                    if (pageController.position.haveDimensions) {
                      pageOffset = pageController.page! - index;
                    }
                    double scale = 1.0 - (pageOffset.abs() * 0.15);
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset(0, 20),
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                images[index],
                                height: 320,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: Icon(
                                  Icons.favorite_outline_outlined,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                food['name']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            food['description']!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
