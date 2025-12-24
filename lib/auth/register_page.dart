import 'package:flutter/material.dart';
import 'package:project_62i/auth/login_page.dart';
import 'package:project_62i/home_page.dart';
import 'package:project_62i/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  void register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    setState(() {
      _isLoading = true;
    });
    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      final user = authResponse.user;
      if (user != null) {
        // Save extra user info in profiles table
        await _supabase.from('profiles').insert({
          'id': user.id, // Link to auth.users
          'name': name,
          'email': email,
        });
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registered Successfully!!")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _cPasswordController.clear();
    } on AuthApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
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
        title: Text("Register Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Card(
            color: Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Register Form", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 30),
                    InputField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      label: "Name",
                      hint: "Enter Name",
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter name";
                        }
                        if (!RegExp(r'^[a-zA-Z \.]+$').hasMatch(value)) {
                          return "Please a valid name!!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    InputField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      hint: "Enter Email",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                        // if (!RegExp(
                        //   r'^(cse|eee|ce)_\d{16}@lus\.ac\.bd$',
                        // ).hasMatch(value)) {
                        //   return "Please enter your institutional email!!";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    InputField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      label: "Password",
                      hint: "Enter Password",
                      icon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter password";
                        }
                        if (value.length < 8) {
                          return "Length must be more then 8";
                        }
                        if (!RegExp(
                          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$',
                        ).hasMatch(value)) {
                          return "Enter a strong password!!";
                        }
                        if (_passwordController.text !=
                            _cPasswordController.text) {
                          return "password and confirm password does't match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    InputField(
                      controller: _cPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      label: "Confirm Password",
                      hint: "Enter Confirm Password",
                      icon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter confirm password";
                        }
                        if (value.length < 8) {
                          return "Length must be more then 8";
                        }
                        if (!RegExp(
                          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$',
                        ).hasMatch(value)) {
                          return "Enter a strong password!!";
                        }
                        if (_passwordController.text !=
                            _cPasswordController.text) {
                          return "password and confirm password does't match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register();
                        }
                      },
                      child:
                          _isLoading
                              ? CircularProgressIndicator()
                              : Text("Register"),
                    ),
                    SizedBox(height: 20),

                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          ),
                      child: Text("Already have an account? Login"),
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
