const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const dogRoutes = require('./routes/dogRoutes');
const ownerRoutes = require('./routes/ownerRoutes');

// Initialize Express app
const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Set up routes
app.use('/api', dogRoutes);
app.use('/api', ownerRoutes);

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/petAdoption', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('MongoDB connection error:', err));

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
