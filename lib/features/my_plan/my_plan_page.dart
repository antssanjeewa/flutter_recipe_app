// features/home/pages/home_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/product_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants.dart';
import '../../models/product.dart';

class MyPlanPage extends StatefulWidget {
  const MyPlanPage({super.key});

  @override
  State<MyPlanPage> createState() => _MyPlanPageState();
}

class _MyPlanPageState extends State<MyPlanPage> {
  int currentCategory = 0;
  int currentProduct = 0;
  PageController? controller;
  double viewPortFraction = 0.5;
  double? pageOffset = 1;
  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 1,
      viewportFraction: viewPortFraction,
    )..addListener(() {
      setState(() {
        pageOffset = controller!.page;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Product> dataProducts =
        products
            .where((element) => element.category == categories[currentCategory])
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
            child: const Stack(
              children: [
                //
                CoffeeItem(degree: 190, right: 160, top: 90),
                CoffeeItem(degree: 90, left: -50, top: 5),
                CoffeeItem(degree: 10, left: -70, top: 140),
                CoffeeItem(degree: 75, right: -20, top: 150),
                CoffeeItem(degree: 100, right: -70, top: 300),
                CoffeeItem(degree: 155, right: 70, top: 350),
              ],
            ),
          ),
          const Positioned(
            top: 30,
            left: 40,
            child: Text(
              "Smooth Out\nYour Everyday",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
          ),
          Positioned(
            top: 120,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 190,
                width: size.width,
                color: AppColors.kSecondary,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => Container(
                      height: 190,
                      width: 107,
                      color:
                          currentCategory == index
                              ? Colors.amber
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 125,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 280,
                width: size.width,
                color: AppColors.kSecondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(categories.length, (index) {
                    int decrease = 0;
                    int max = 1;
                    int bottomPadding = 1;

                    for (var i = 0; i < categories.length; i++) {
                      bottomPadding = index > max ? index - decrease++ : index;
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentCategory = index;
                          dataProducts =
                              products
                                  .where(
                                    (element) =>
                                        element.category ==
                                        categories[currentCategory],
                                  )
                                  .toList();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: bottomPadding.abs() * 75,
                        ),
                        child: CategoryItem(category: categories[index]),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: size.height * 0.53,
                width: size.width,
                color: const Color.fromARGB(255, 62, 233, 167),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: Container(
                    height: size.height * 0.53,
                    width: size.width,
                    color: Colors.transparent,
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          currentProduct = value % dataProducts.length;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = max(
                          viewPortFraction,
                          (1 - (pageOffset! - index).abs() + viewPortFraction),
                        );
                        double angle = 0.0;
                        final items = dataProducts[index % dataProducts.length];

                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         DetailPage(product: items),
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 200 - (scale / 1.6 * 170),
                            ),
                            child: Transform.rotate(
                              angle: angle * pi,
                              child: Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [ProductImage(product: items)],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dataProducts[currentProduct % dataProducts.length]
                                .name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${dataProducts[currentProduct % dataProducts.length].price}0',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        dataProducts.length,
                        (index) => indicator(index, currentProduct),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Row(
        children: [
          Image.asset("images/coffee-cup.png", color: Colors.amber, height: 30),
          const SizedBox(width: 5),
          const Column(
            children: [
              Text(
                "Shop",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("Space", style: TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
      actions: [
        Center(
          child: Stack(
            children: [
              const Icon(Icons.shopping_cart, color: Colors.amber),
              Positioned(
                right: 3,
                top: 0,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}

AnimatedContainer indicator(int index, currentProduct) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        width: 3,
        color:
            index == currentProduct ? Colors.amberAccent : Colors.transparent,
      ),
    ),
    padding: const EdgeInsets.all(10),
    child: Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: index == currentProduct ? Colors.white : Colors.white60,
        shape: BoxShape.circle,
      ),
    ),
  );
}

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 75,
          width: 75,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset("images/${category.image}"),
        ),
        const SizedBox(height: 10),
        Text(
          category.name.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class CoffeeItem extends StatelessWidget {
  final double? degree, top, left, bottom, right;
  const CoffeeItem({
    super.key,
    this.degree,
    this.top,
    this.left,
    this.bottom,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: degree! * pi / 190,
        child: SvgPicture.asset("images/coffee-bean.svg", width: 150),
      ),
    );
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100);
    path.quadraticBezierTo(size.width / 2, -40, 0, 100);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
