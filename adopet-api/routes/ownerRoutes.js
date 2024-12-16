const express = require('express');
const router = express.Router();
const Owner = require('../models/owner');  // Importez le modèle Owner

// Route pour récupérer tous les propriétaires
router.get('/owners', async (req, res) => {
  try {
    // Récupère tous les propriétaires de la base de données
    const owners = await Owner.find();

    // Si aucun propriétaire n'est trouvé
    if (!owners) {
      return res.status(404).json({ message: 'No owners found' });
    }

    // Envoie la liste des propriétaires sous forme de JSON
    res.json(owners);
  } catch (error) {
    // Gère les erreurs potentielles
    res.status(500).json({ message: 'Server Error', error: error.message });
  }
});

module.exports = router;