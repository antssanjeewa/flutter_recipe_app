// features/home/home_page.dart
import '../models/recipe.dart';
import '../services/favorite_provider.dart';
import '../app/app_pages.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoriteProvider>();
    final isFavorite = provider.isExist(recipe);

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Pages.recipeDetails.toPathName(),
          pathParameters: {'id': recipe.id},
          extra: recipe,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: recipe.image,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Iconsax.flash_1, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      "${recipe.cal} Cal",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Iconsax.clock, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      "${recipe.time} Min",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    provider.toggleFavorite(recipe);
                  },
                  child: Icon(
                    isFavorite ? Iconsax.heart5 : Iconsax.heart,
                    size: 20,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
