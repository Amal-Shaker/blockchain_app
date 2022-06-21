import 'package:blockchain_app/firstPage.dart';
import 'package:blockchain_app/home_page.dart';
import 'package:blockchain_app/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}
