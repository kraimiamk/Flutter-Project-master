class Owner {
  final String name;        // Name of the owner
  final String bio;         // Short description of the owner
  final String imageUrl;    // URL or path to the owner's image

  Owner({
    required this.name,
    required this.bio,
    required this.imageUrl,
  });

  // Convert Owner to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }

  // Convert JSON to Owner object
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'],
      bio: json['bio'],
      imageUrl: json['imageUrl'],
    );
  }
}

