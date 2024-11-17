import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepByStepForm(),
    );
  }
}

class StepByStepForm extends StatefulWidget {
  @override
  _StepByStepFormState createState() => _StepByStepFormState();
}

class _StepByStepFormState extends State<StepByStepForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode messageFocus = FocusNode();

  int currentStep = 0;

  List<Widget> steps = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();

    focusNodes = [nameFocus, emailFocus, messageFocus];

    steps = [
      buildStep("Nom", nameController, nameFocus),
      buildStep("Email", emailController, emailFocus),
      buildStep("Message", messageController, messageFocus),
    ];

    // Positionne le focus sur le premier champ par défaut
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[currentStep].requestFocus();
    });
  }

  Widget buildStep(String label, TextEditingController controller, FocusNode focusNode) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 20)),
        TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(hintText: 'Entrez votre $label'),
        ),
      ],
    );
  }

  void nextStep() {
    setState(() {
      if (currentStep < steps.length - 1) {
        currentStep++;
      }
    });

    // Change le focus après que l'interface a été mise à jour
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[currentStep].requestFocus();
    });
  }

  void sendMessage() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty) {
      // Ici vous pouvez ajouter votre logique d'envoi de mail
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Message envoyé"),
          content: Text("Votre message a été envoyé avec succès."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulaire Step-by-Step')),
      body: Stack(
        children: [
          // Voile gris couvrant toute la fenêtre
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Champ actif mis en avant (sans voile)
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < steps.length; i++)
                    if (i == currentStep)
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white, // Fond blanc pour le champ actif
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: steps[i],
                        ),
                      )
                    else
                    // Les autres champs sont gris
                      Opacity(
                        opacity: 0.3,
                        child: steps[i],
                      ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: currentStep < steps.length - 1
                        ? nextStep
                        : sendMessage,
                    child: Text(currentStep < steps.length - 1
                        ? 'Suivant'
                        : 'Envoyer'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
