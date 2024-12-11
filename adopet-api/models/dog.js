
const mongoose = require('mongoose');

// Create a schema for the Dog model
const dogSchema = new mongoose.Schema({
  name: { type: String, required: true },
  age: { type: Number, required: true },
  gender: { type: String, required: true },
  color: { type: String, required: true },
  weight: { type: Number, required: true },
  distance: { type: String, required: true },
  imageUrl: { type: String, required: true },
  description: { type: String, required: true },
  owner: {
    name: { type: String, required: true },
    bio: { type: String, required: true },
    imageUrl: { type: String, required: true }
  }
});

module.exports = mongoose.model('Dog', dogSchema);
