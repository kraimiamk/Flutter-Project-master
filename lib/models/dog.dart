import '../models/owner.dart';
import '../models/owner.dart';

class Dog {
  final int id;
  final String name;
  final double age;
  final String gender;
  final String color;
  final double weight;
  final String distance;
  final String imageUrl;
  final String description;
  final Owner owner;

  Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.distance,
    required this.imageUrl,
    required this.description,
    required this.owner,
  });

  // Convert JSON to Dog object
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: int.tryParse(json['_id'].toString()) ?? 0,  // Try parsing to int, default to 0 if failed
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      color: json['color'],
      weight: json['weight'],
      distance: json['distance'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      owner: Owner.fromJson(json['owner']),
    );
  }


  // Convert Dog to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'color': color,
      'weight': weight,
      'distance': distance,
      'imageUrl': imageUrl,
      'description': description,
      'owner': owner.toJson(),  // Ensure owner is serialized to JSON
    };
  }
}
