import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app_pages.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  //  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Discover Recipes",
      "desc": "Find amazing recipes with ingredients you love!",
      "image": "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
    },
    {
      "title": "Save Your Favorites",
      "desc": "Bookmark your favorite dishes for quick access later.",
      "image": "https://cdn-icons-png.flaticon.com/512/833/833472.png",
    },
    {
      "title": "Start Cooking",
      "desc": "Follow step-by-step instructions to cook easily.",
      "image": "https://cdn-icons-png.flaticon.com/512/135/135620.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                    top: -70,
                    left: 0,
                    right: 0,
                    child: FadeInDown(
                      delay: const Duration(microseconds: 500),
                      child: Image.network(
                        onboardingData[index]['image']!,
                        width: 600,
                        height: 600,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 1.9,
                    left: 0,
                    right: 0,
                    child: FadeInUp(
                      delay: const Duration(microseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              onboardingData[index]['title']!,
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              onboardingData[index]['desc']!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            bottom: 170,
            left: 25,
            child: FadeInUp(
              delay: const Duration(microseconds: 500),
              child: Row(
                children: [
                  ...List.generate(
                    onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(microseconds: 250),
                      height: 5,
                      width: 50,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color:
                            currentIndex == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            child: FadeInUp(
              delay: const Duration(microseconds: 500),
              child: SizedBox(
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(
                    onPressed: () {
                      Pages.home.go(context);
                    },
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: MediaQuery.of(context).size.width - 50,
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
