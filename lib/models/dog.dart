import '../models/owner.dart';

class Dog {
  final String id; // Change to String to accommodate MongoDB ObjectId
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
    required this.id, // Change the type to String here
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
      id: json['_id'].toString(),  // Ensure we treat _id as String
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
      '_id': id,  // Ensure the id is included in the JSON data
      'name': name,
      'age': age,
      'gender': gender,
      'color': color,
      'weight': weight,
      'distance': distance,
      'imageUrl': imageUrl,
      'description': description,
      'owner': owner.toJson(),
    };
  }
}
