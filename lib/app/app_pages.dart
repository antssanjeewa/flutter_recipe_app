import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Pages { home, favorites, plan, settings, recipes, recipeDetails }

extension PagesExtension on Pages {
  String toPath({bool isSubRoute = false}) {
    if (isSubRoute) {
      return name; // e.g., "home"
    }
    return '/$name'; // e.g., "/home"
  }

  String toPathName() => name;

  void go(BuildContext context) {
    GoRouter.of(context).goNamed(toPathName());
  }

  void push(BuildContext context) {
    GoRouter.of(context).pushNamed(toPathName());
  }
}
