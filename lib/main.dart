import 'package:authproject/screens/phone_input_screen.dart';
import 'package:authproject/screens/reset_password_screen.dart';
import 'package:authproject/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qklihnthoubxwusrsrwb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFrbGlobnRob3VieHd1c3JzcndiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcxODg0MTEsImV4cCI6MjA4Mjc2NDQxMX0.ykWIeZCCIA51ktOSd6fJrB7FHeHFZ3lj_KCdjhkEd4U',
    authOptions: FlutterAuthClientOptions(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final user = Supabase.instance.client.auth.currentUser;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(locale: Locale('ar'), home: ResetPasswordScreen());
  }
}
