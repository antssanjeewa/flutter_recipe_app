// app/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_home_screen.dart';
import 'app_pages.dart';
import '../models/recipe.dart';
import '../features/onboard/onboard_screen.dart';
import '../features/home/recipe_details_page.dart';
import '../features/home/view_all_page.dart';
import '../features/favorite/favorite_page.dart';
import '../features/my_plan/my_plan_page.dart';
import '../features/setting/setting_page.dart';
import '../features/home/home_page.dart';

GoRouter router(bool showOnboarding) => GoRouter(
  initialLocation:
      showOnboarding ? Pages.onboarding.toPath() : Pages.plan.toPath(),
  routes: [
    GoRoute(
      name: Pages.onboarding.toPathName(),
      path: Pages.onboarding.toPath(),
      builder: (context, state) => const OnboardScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppHomeScreen(child: child),
      routes: [
        GoRoute(
          name: Pages.home.toPathName(),
          path: Pages.home.toPath(),
          // builder: (context, state) => const HomePage(),
          pageBuilder:
              (context, state) => slideTransitionPage(const HomePage()),
        ),
        GoRoute(
          name: Pages.favorites.toPathName(),
          path: Pages.favorites.toPath(),
          // builder: (context, state) => const FavoritePage(),
          pageBuilder:
              (context, state) => slideTransitionPage(const FavoritePage()),
        ),
        GoRoute(
          name: Pages.plan.toPathName(),
          path: Pages.plan.toPath(),
          // builder: (context, state) => const MyPlanPage(),
          pageBuilder:
              (context, state) => slideTransitionPage(const MyPlanPage()),
        ),
        GoRoute(
          name: Pages.settings.toPathName(),
          path: Pages.settings.toPath(),
          // builder: (context, state) => const SettingPage(),
          pageBuilder:
              (context, state) => slideTransitionPage(const SettingPage()),
        ),
      ],
    ),
    GoRoute(
      name: Pages.recipes.toPathName(),
      path: Pages.recipes.toPath(),
      pageBuilder:
          (context, state) => const MaterialPage(
            fullscreenDialog: true, // 👈 This makes it a modal-style route
            child: ViewAllPage(),
          ),
      routes: [
        GoRoute(
          path: ':id', // This becomes /recipes/:id
          name: Pages.recipeDetails.toPathName(),
          builder: (context, state) {
            final recipe = state.extra as Recipe;
            return RecipeDetailsPage(recipe: recipe);
          },
        ),
      ],
    ),
  ],
);

CustomTransitionPage slideTransitionPage(Widget child) => CustomTransitionPage(
  child: child,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  },
);
