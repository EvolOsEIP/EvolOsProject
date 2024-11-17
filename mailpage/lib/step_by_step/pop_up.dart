import 'package:flutter/material.dart';

Future<void> showPopup(BuildContext context, String description, String buttonText, VoidCallback onPressed) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Step-by-Step Tutorial"),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Go NEXT!')),
              );
            },
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}

Widget _buildStepOverlay({
  required BuildContext context,
  required Widget child,
  required Widget focusWidget,
  String? overlayText,
}) {
  return Stack(
    children: [
      // Superposer l'écran grisé
      Positioned.fill(
        child: GestureDetector(
          onTap: () {},  // Empêche les interactions
          child: Container(
            color: Colors.black.withOpacity(0.5),  // Effet de gris
          ),
        ),
      ),
      // Focus sur l'élément spécifique
      Positioned(
        left: 50, // Position de l'élément à mettre en surbrillance
        top: 100, // Modifier pour le bon positionnement
        child: Focus(
          focusNode: FocusNode(), // Tu peux utiliser un FocusNode pour gérer le focus
          child: child,
        ),
      ),
      // Pop-up de description si nécessaire
      if (overlayText != null)
        Positioned(
          top: 50, // Position du pop-up
          left: 50,
          child: Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Text(overlayText),
            ),
          ),
        ),
    ],
  );
}

Future<void> _startTutorial() async {
  // Étape 1 : Bienvenue
  await showPopup(
    context,
    "Bonjour, bienvenue dans le tuto pour apprendre à envoyer un mail.",
    "Je commence",
        () {
      Navigator.of(context).pop();  // Fermer le pop-up
      _showFirstStep();
    },
  );
}

void _showFirstStep() {
  setState(() {
    _isStepOneActive = true;
  });

  // Étape 2 : Focus sur le destinataire avec l'écran gris
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Step 1"),
        content: _buildStepOverlay(
          context: context,
          child: _buildTextField(_recipientController, "Destinataire", hintText: "ex: recipent@mail.com"),
          focusWidget: _recipientController,
          overlayText: "Tapez le destinataire ici.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextStep();
            },
            child: const Text("Suivant"),
          ),
        ],
      );
    },
  );
}

void _nextStep() {
  // Gérer les étapes suivantes ici, en continuant à mettre en surbrillance les autres éléments
}
