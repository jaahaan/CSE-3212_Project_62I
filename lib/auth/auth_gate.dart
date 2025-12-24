import 'package:flutter/material.dart';
import 'package:project_62i/auth/login_page.dart';
import 'package:project_62i/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*
AuthGate = This will continuously listen for auth state changes.
stream = listen to auth state changes
builder = Build appropriate page based on auth state

if auth -> HomePage
else -> LoginPage
*/

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
