import 'package:flutter/material.dart';
import 'package:project_62i/widgets/input_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String name = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.blueGrey),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Card(
            color: Colors.blueGrey[200],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      label: "Name",
                      hint: "Enter Name",
                      icon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is Empty";
                        } else if (!RegExp(
                          r'^[A-Za-z .]{3,}$',
                        ).hasMatch(value)) {
                          return 'Invalid Format!!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputField(
                      controller: passController,
                      keyboardType: TextInputType.visiblePassword,
                      label: "Password",
                      hint: "Enter Password",
                      icon: Icons.lock,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is Empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            name = nameController.text;
                          }
                        });
                      },
                      child: Text("Submit"),
                    ),
                    SizedBox(height: 20),
                    Text("Name is: $name"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
