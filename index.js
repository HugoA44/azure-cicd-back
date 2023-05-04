const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());

// Liste de prénoms
const prenoms = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];

app.get('/', (req, res) => {
  res.send('Bienvenue!');
});

// Route pour renvoyer la liste des prénoms
app.get('/prenoms', (req, res) => {
  res.json(prenoms);
});

// Démarrer le serveur
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Serveur démarré sur le port ${PORT}`);
});
