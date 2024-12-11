import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.14:5000/api';

  Future<List<Dog>> fetchDogs() async {
    final response = await http.get(Uri.parse('$baseUrl/dogs'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dog) => Dog.fromJson(dog)).toList();
    } else {
      throw Exception('Failed to load dogs');
    }
  }

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

  Future<void> deleteDog(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/dogs/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete dog');
    }
  }
}
