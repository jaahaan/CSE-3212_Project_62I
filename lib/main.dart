import 'package:flutter/material.dart';
import 'package:project_62i/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bznblrxfbnghpubcrong.supabase.co',
    anonKey: 'sb_publishable_AjTI1khentv_FUzAvqbKIg_T1P0nZry',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: AuthGate(),
    );
  }
}
