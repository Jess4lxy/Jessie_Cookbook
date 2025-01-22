import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jessie Cookbook')),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/design'),
              child: const Text('Design'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/images'),
              child: const Text('Images'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/list'),
              child: const Text('List'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/forms'),
              child: const Text('Forms'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/navigation'),
              child: const Text('Navigation'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/animation'),
              child: const Text('Animation'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/persistance'),
              child: const Text('Persistance/Storage'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/networking'),
              child: const Text('Networking'),
            ),
          ],
        ),
      ),
    );
  }
}