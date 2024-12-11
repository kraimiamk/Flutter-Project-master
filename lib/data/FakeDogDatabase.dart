import '../models/dog.dart';
import '../models/owner.dart';

// Correctly creating the Owner object with named parameters
Owner owner = Owner(
  name: "Spikey Sanju",
  bio: "Developer & Pet Lover",
  imageUrl: "assets/drawable-v24/owner.png",  // Corrected image path
);

// Corrected dog list with proper asset paths and named constructor parameters
List<Dog> dogList = [
  Dog(
    id: 0,
    name: "Hachiko",
    age: 3.5,
    gender: "Male",
    color: "Brown",
    weight: 12.9,
    distance: "389m away",
    imageUrl: "assets/drawable/orange_dog.png",  // Corrected asset path
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
    owner: owner,  // Correctly passed the owner object
  ),
  Dog(
    id: 1,
    name: "Skooby Doo",
    age: 3.5,
    gender: "Male",
    color: "Gold",
    weight: 12.4,
    distance: "412m away",
    imageUrl: "assets/drawable/blue_dog.png",  // Corrected asset path
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
    owner: owner,
  ),
  Dog(
    id: 2,
    name: "Miss Agnes",
    age: 3.5,
    gender: "Female",
    color: "White",
    weight: 9.6,
    distance: "879m away",
    imageUrl: "assets/drawable/red_dog.png",  // Corrected asset path
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
    owner: owner,
  ),
  Dog(
    id: 3,
    name: "Cyrus",
    age: 3.5,
    gender: "Male",
    color: "Black",
    weight: 8.2,
    distance: "672m away",
    imageUrl: "assets/drawable/yellow_dog.png",  // Corrected asset path
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
    owner: owner,
  ),
  Dog(
    id: 4,
    name: "Shelby",
    age: 3.5,
    gender: "Female",
    color: "Choco",
    weight: 14.9,
    distance: "982m away",
    imageUrl: "assets/drawable/white_dog.png",  // Corrected asset path
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
    owner: owner,
  ),
];

