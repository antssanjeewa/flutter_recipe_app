import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../services/favorite_provider.dart';
import '../../services/quantity_provider.dart';
import '../../utils/constants.dart';
import '../../widget/QntIncreaseDecrease.dart';
import '../../models/recipe.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final quantityProvider = context.watch<QuantityProvider>();
    final provider = context.watch<FavoriteProvider>();
    final isFavorite = provider.isExist(widget.recipe);

    final ingredients = [
      {
        "name": "Ginger",
        "imageUrl":
            "https://pngimg.com/uploads/ginger/small/ginger_PNG99266.png",
        "quantity": "300",
      },
      {
        "name": "Garlic",
        "imageUrl":
            "https://pngimg.com/uploads/garlic/small/garlic_PNG12799.png",
        "quantity": "200",
      },
      {
        "name": "Tomato",
        "imageUrl": "https://pngimg.com/uploads/tomato/tomato_PNG12571.png",
        "quantity": "150",
      },
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomActionButton(provider, isFavorite),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.recipe.image,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.recipe.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.white,
                      fixedSize: const Size(50, 50),
                    ),
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width - 15,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Iconsax.flash_1, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.recipe.cal} Cal",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Iconsax.clock, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.recipe.time} Min",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Iconsax.star1, color: Colors.amberAccent),
                      SizedBox(width: 5),
                      Text(
                        "3.2",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("/5"),
                      SizedBox(width: 5),
                      Text("5 Reviews", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredient",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "How many serving?",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      const Spacer(),
                      QntIncreaseDecrease(
                        currentNumber: quantityProvider.currentNumber,
                        onAdd: () => quantityProvider.increaseQuantity(),
                        onRemove: () => quantityProvider.decreaseQuantity(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children:
                        ingredients.map((item) {
                          return ingredientItem(item, quantityProvider);
                        }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row ingredientItem(Map<String, String> item, quantityProvider) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                item['imageUrl']!,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  item['name']!,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  "${int.parse(item['quantity']!) * quantityProvider.currentNumber}",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  FloatingActionButton bottomActionButton(
    FavoriteProvider provider,
    bool isFavorite,
  ) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: Colors.transparent,
      elevation: 0,
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimary,
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 13,
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text(
              "Start Cooking",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: IconButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            onPressed: () {
              provider.toggleFavorite(widget.recipe);
            },
            icon: Icon(
              isFavorite ? Iconsax.heart5 : Iconsax.heart,
              size: 22,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
