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
  String gender = '';  // Will hold selected gender
  String color = '';
  double weight = 0;
  String distance = '';
  String imageUrl = '';
  String description = '';
  String ownerName = '';
  String ownerBio = '';
  String ownerImageUrl = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Dog newDog = Dog(
        id: '0', // Temporary ID for now, will be set by the backend
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
      appBar: AppBar(
        title: Text('Add Dog'),
        backgroundColor: Colors.teal, // Dark green color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          icon: Icon(Icons.pets, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s name' : null,
                        onChanged: (value) => name = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Age',
                          icon: Icon(Icons.accessibility_new, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s age' : null,
                        onChanged: (value) => age = double.parse(value),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          icon: Icon(Icons.male, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        value: gender.isEmpty ? null : gender,
                        validator: (value) => value == null || value.isEmpty ? 'Please select the dog\'s gender' : null,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: 'Male', child: Text('Male')),
                          DropdownMenuItem(value: 'Female', child: Text('Female')),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Color',
                          icon: Icon(Icons.color_lens, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s color' : null,
                        onChanged: (value) => color = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          icon: Icon(Icons.fitness_center, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s weight' : null,
                        onChanged: (value) => weight = double.parse(value),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Distance (km)',
                          icon: Icon(Icons.location_on, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s distance' : null,
                        onChanged: (value) => distance = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          icon: Icon(Icons.image, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s image URL' : null,
                        onChanged: (value) => imageUrl = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          icon: Icon(Icons.description, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the dog\'s description' : null,
                        onChanged: (value) => description = value,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Owner Name',
                          icon: Icon(Icons.account_circle, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the owner\'s name' : null,
                        onChanged: (value) => ownerName = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Owner Bio',
                          icon: Icon(Icons.person, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the owner\'s bio' : null,
                        onChanged: (value) => ownerBio = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Owner Image URL',
                          icon: Icon(Icons.image, color: Colors.teal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter the owner\'s image URL' : null,
                        onChanged: (value) => ownerImageUrl = value,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Beautiful green color
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
