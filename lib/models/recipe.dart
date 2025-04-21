import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String name;
  final String image;
  final String cal;
  final String time;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cal,
    required this.time,
  });

  factory Recipe.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Recipe(
      id: doc.id,
      name: data['name'],
      image: data['image'],
      cal: data['cal'],
      time: data['time'],
    );
  }
}
