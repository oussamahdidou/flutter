import 'package:flutter/material.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? gender;
  DateTime? rulesDate;
  bool usesDrugs = false;

  // Function to show a date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != rulesDate) {
      setState(() {
        rulesDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Sexe'),
                value: gender,
                onChanged: (String? newValue) {
                  setState(() {
                    gender = newValue;
                  });
                },
                items: <String>['Homme', 'Femme', 'Autre']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un sexe';
                  }
                  return null;
                },
              ),
              if (gender == 'Femme')
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      labelText: 'Date des règles', hintText: 'YYYY-MM-DD'),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
              SwitchListTile(
                title: Text('Consomme des drogues ?'),
                value: usesDrugs,
                onChanged: (bool value) {
                  setState(() {
                    usesDrugs = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Soumettre le formulaire
                    // Logique à ajouter ici, comme envoyer les données à une API
                    print('Nom: ${nameController.text}');
                    print('Sexe: $gender');
                    if (gender == 'Femme') {
                      print('Date des règles: $rulesDate');
                    }
                    print('Consomme des drogues: $usesDrugs');
                  }
                },
                child: Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
