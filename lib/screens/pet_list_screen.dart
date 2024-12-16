import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/dog.dart';
import '../services/api_service.dart';
import 'pet_detail_screen.dart';
import '../crud/Add_Dog.dart';
import '../crud/Edit_Dog.dart';
import '../conex/login_screen.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  late Future<List<Dog>> dogList;
  String searchQuery = ''; // Store the current search query

  @override
  void initState() {
    super.initState();
    dogList = ApiService().fetchDogs(); // Fetch dogs from API initially
  }

  // Method to search dogs by name
  Future<void> _searchDogs(String query) async {
    setState(() {
      searchQuery = query;
    });

    if (query.isEmpty) {
      // If search query is empty, fetch all dogs
      dogList = ApiService().fetchDogs();
    } else {
      // Fetch dogs based on search query
      dogList = ApiService().searchDogsByName(query);
    }
  }

  // Method to delete a dog from the list with confirmation
  Future<void> _deleteDog(String id) async {
    // Show a confirmation dialog before deleting
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners for the dialog
          ),
          backgroundColor: Colors.green[50], // Light green background color
          title: Row(
            children: [
              Icon(Icons.delete_forever, color: Colors.green), // Icon for emphasis
              SizedBox(width: 10),
              Text(
                'Delete Dog',
                style: TextStyle(
                  color: Colors.green[800], // Title text color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete this dog?',
            style: TextStyle(
              color: Colors.black87, // Content text color
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[100], // Light green background for cancel
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.green[800]), // Dark green text color for Cancel
              ),
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss dialog and return false
              },
            ),
            SizedBox(width: 10), // Space between buttons
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[500], // Medium green background for 'Yes'
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white, // White text on green background
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion and return true
              },
            ),
          ],
        );
      },
    );

    // If the user confirms, delete the dog
    if (confirmDelete == true) {
      try {
        await ApiService().deleteDog(id);  // Delete the dog from the API

        // Refresh the dog list
        final updatedDogs = await ApiService().fetchDogs();  // Wait for the updated dog list
        setState(() {
          dogList = Future.value(updatedDogs);  // Update dogList with the new data
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dog deleted successfully!')),
        );
      } catch (e) {
        // Show error message if deletion fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete dog: $e')),
        );
      }
    }
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
        title: const Text(
          'Available Dogs',
          style: TextStyle(
            color: Colors.white, // White title text for contrast
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, // Beautiful green background color
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Optional: Adjust padding for better alignment
          child: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/adopet.png'), // Replace with your logo path
          ),
        ),
        actions: [
          // Search bar in AppBar
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white, // White icon for contrast
            ),
            onPressed: _logout,  // Call the logout method when pressed
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: _searchDogs,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green[400]!),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.green),
              ),
            ),
          ),
        ),
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
                          // Navigate to the Edit Dog screen and pass the selected dog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDogScreen(dog: dog),
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
        backgroundColor: Colors.teal, // Set the green background color
        child: Icon(
          Icons.add,
          color: Colors.white, // White icon color for contrast
        ),
      ),
    );
  }
}





