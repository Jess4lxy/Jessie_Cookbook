import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/design_screen.dart';
import 'screens/image_screen.dart';
import 'screens/list_screen.dart';
import 'screens/forms_screen.dart';
import 'screens/navigation_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Jessie Cookbook';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/design': (context) => const DesignScreen(),
        '/images': (context) => const ImagesScreen(),
        '/list': (context) => const ListScreen(),
        '/forms': (context) => const FormsScreen(),
        '/navigation': (context) => const NavigationScreen(),
      },
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
