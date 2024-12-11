import 'package:flutter/material.dart';
import '../models/dog.dart';
import '../models/owner.dart';
import '../services/api_service.dart';


class AddDogScreen extends StatefulWidget {
  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  String name = '';
  double age = 0;
  String gender = '';
  String color = '';
  double weight = 0;
  String distance = '';
  String imageUrl = '';
  String description = '';
  String ownerName = '';
  String ownerBio = '';
  String ownerImageUrl = '';

  // Form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Dog newDog = Dog(
        id: 0, // Temporary ID for now, will be set by the backend
        name: name,
        age: age,
        gender: gender,
        color: color,
        weight: weight,
        distance: distance,
        imageUrl: imageUrl,
        description: description,
        owner: Owner(
          name: ownerName,
          bio: ownerBio,
          imageUrl: ownerImageUrl,
        ),
      );

      apiService.addDog(newDog).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dog added successfully!')));
        Navigator.pop(context); // Go back to the previous screen
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add dog')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dog')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Dog Details
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s name' : null,
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s age' : null,
                onChanged: (value) => age = double.parse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s gender' : null,
                onChanged: (value) => gender = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Color'),
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s color' : null,
                onChanged: (value) => color = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s weight' : null,
                onChanged: (value) => weight = double.parse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Distance'),
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s distance' : null,
                onChanged: (value) => distance = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s image URL' : null,
                onChanged: (value) => imageUrl = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter the dog\'s description' : null,
                onChanged: (value) => description = value,
              ),

              // Owner Details
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the owner\'s name' : null,
                onChanged: (value) => ownerName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Bio'),
                validator: (value) => value!.isEmpty ? 'Please enter the owner\'s bio' : null,
                onChanged: (value) => ownerBio = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Image URL'),
                validator: (value) => value!.isEmpty ? 'Please enter the owner\'s image URL' : null,
                onChanged: (value) => ownerImageUrl = value,
              ),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add Dog'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
