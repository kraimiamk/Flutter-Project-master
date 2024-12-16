import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/dog.dart';
import '../services/api_service.dart';
import 'pet_detail_screen.dart';
import '../crud/Add_Dog.dart';
import '../conex/login_screen.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  late Future<List<Dog>> dogList;

  @override
  void initState() {
    super.initState();
    dogList = ApiService().fetchDogs();  // Fetch dogs from API
  }

  // Method to delete a dog from the list
  Future<void> _deleteDog(int id) async {
    await ApiService().deleteDog(id);
    setState(() {
      dogList = ApiService().fetchDogs();  // Refresh dog list after deletion
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dog deleted successfully!')));
  }

  // Method to log out the user
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();  // Log out the user from Firebase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),  // Navigate to LoginScreen after logout
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Dogs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,  // Call the logout method when pressed
          ),
        ],
      ),
      body: FutureBuilder<List<Dog>>(
        future: dogList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No dogs available.'));
          }

          final dogs = snapshot.data!;

          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(dog.imageUrl),  // Use network image from API
                  ),
                  title: Text(
                    dog.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        '${dog.age} yrs | ${dog.gender}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${dog.distance}m away',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '12 min ago',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit button to update dog details
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to the Pet Detail Screen with the selected dog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetDetailScreen(dog: dog),
                            ),
                          );
                        },
                      ),
                      // Delete button to delete the dog
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteDog(dog.id),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to the Pet Detail Screen with the selected dog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetDetailScreen(dog: dog),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      // Floating Action Button to add a new dog
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Dog screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDogScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}




