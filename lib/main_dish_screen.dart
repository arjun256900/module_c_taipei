import 'package:flutter/material.dart';

class MainDishScreen extends StatefulWidget {
  final Map<String, dynamic> type;
  const MainDishScreen({super.key, required this.type});

  @override
  State<MainDishScreen> createState() => _MainDishScreenState();
}

class _MainDishScreenState extends State<MainDishScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list1 = [];
    List<Widget> list2 = [];

    // 1. Extract your foods list (Adjust the key 'foods' if your JSON uses a different word)
    final List<dynamic> foods = widget.type['foods'] ?? [];

    // 2. The Logic: Evens to the left, Odds to the right
    for (int i = 0; i < foods.length; i++) {
      final card = _buildFoodCard(foods[i]);
      if (i % 2 == 0) {
        list1.add(card);
      } else {
        list2.add(card);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,

      // --- APP BAR POLISH ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.type['type'] ?? "Main dishes",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Adds that subtle 1px gray line under the AppBar seen in the image
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),

      // --- THE "FAKED" GRID ---
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            // CRITICAL: This stops the columns from stretching vertically to match each other!
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: list1)),
              const SizedBox(width: 12), // The gap between the two columns
              Expanded(child: Column(children: list2)),
            ],
          ),
        ),
      ),
    );
  }

  // --- THE CARD WIDGET ---
  Widget _buildFoodCard(dynamic food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/${food['image_url'] ?? food['name'] + '.jpg'}", // Adjust key to match JSON
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                food['name'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
