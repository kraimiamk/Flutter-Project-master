import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.14:5000/api';

  // Fetch all dogs
  Future<List<Dog>> fetchDogs() async {
    final response = await http.get(Uri.parse('$baseUrl/dogs'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dog) => Dog.fromJson(dog)).toList();
    } else {
      throw Exception('Failed to load dogs');
    }
  }

  // Add a new dog
  Future<void> addDog(Dog dog) async {
    final response = await http.post(
      Uri.parse('$baseUrl/dogs'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dog.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add dog');
    }
  }

  // Update an existing dog
  Future<void> updateDog(Dog dog) async {
    final response = await http.put(
      Uri.parse('$baseUrl/dogs/${dog.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dog.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update dog');
    }
  }

// Delete a dog
  Future<void> deleteDog(String id) async {
    final url = '$baseUrl/dogs/$id'; // Use the string ID
    print('Attempting to delete dog at URL: $url');
    final response = await http.delete(Uri.parse(url));

    print('Delete response status: ${response.statusCode}');
    print('Delete response body: ${response.body}');

    // Consider both 200 (OK) and 204 (No Content) as successful delete responses
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete dog');
    }
  }
  // Search dogs by name
  Future<List<Dog>> searchDogsByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/dogs/search?name=$name'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dog) => Dog.fromJson(dog)).toList();
    } else {
      throw Exception('Failed to search dogs');
    }
  }

}

