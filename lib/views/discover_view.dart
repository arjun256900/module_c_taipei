import 'package:flutter/material.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  final controller = PageController(viewportFraction: 0.8, initialPage: 1);
  final chefDetails = {
    "chef_name": ["Pierre Gagnaire", "Alain Ducasse", "Paul Bocuse"],
    "rating": "4.0",
    "description":
        "His grasp of detail is outstanding, and every dish he cooks is like a meticulously crafted work of art, making people feel his love and dedication to cooking during the tasting process.",
  };

  @override
  Widget build(BuildContext context) {
    final List<String> chefNames = chefDetails['chef_name'] as List<String>;
    final List<String> chefImages = [
      "assets/images/image_2.jpg",
      "assets/images/image_3.jpg",
      "assets/images/image_4.jpg",
    ];
    return Center(
      child: Column(
        children: [
          Text(
            "Chef",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 650,
            child: PageView.builder(
              controller: controller,
              itemCount: chefNames.length,
              itemBuilder: (context, index) {
                final chef = chefNames[index];
                const double avatarRadius = 80;
                const double imageHeight = 220;
                const double avatarPosition = imageHeight - avatarRadius;
                return Container(
                  margin: .symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/Bouillabaisse.jpg",
                              fit: BoxFit.cover,
                              height: imageHeight,
                              width: double.infinity,
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: .only(
                                top: avatarRadius + 20,
                                left: 20,
                                right: 20,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    chef,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                        255,
                                        192,
                                        131,
                                        10,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 25,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 25,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 25,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 25,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        chefDetails['rating'] as String,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    chefDetails['description'] as String,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        top: avatarPosition,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: .center,
                          child: CircleAvatar(
                            radius: avatarRadius,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: avatarRadius - 4,
                              backgroundImage: AssetImage(chefImages[index]),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: imageHeight - 20,
                        right: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
