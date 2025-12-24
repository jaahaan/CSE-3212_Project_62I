import 'package:flutter/material.dart';
import 'package:project_62i/auth/register_page.dart';
import 'package:project_62i/home_page.dart';
import 'package:project_62i/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    setState(() {
      _isLoading = true;
    });
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      _emailController.clear();
      _passwordController.clear();
    } on AuthApiException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 350,
          child: Card(
            color: Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Login Form", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 30),
                    InputField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is empty!!";
                        }
                        // if (!RegExp(r'cse_\d{16}@lus.ac.bd').hasMatch(value)) {
                        //   return "Enter institutional email";
                        // }

                        return null;
                      },
                      label: "Email",
                      hint: "Enter email",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    InputField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is empty!!";
                        }
                        return null;
                      },
                      label: "Password",
                      hint: "Enter password",
                      icon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child:
                          _isLoading
                              ? CircularProgressIndicator()
                              : Text("Login"),
                    ),
                    SizedBox(height: 20),

                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          ),
                      child: Text("Don't have an account? Register"),
                    ),
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
