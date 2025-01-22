import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  late String image; // Declaramos la imagen como `late`.

  @override
  void initState() {
    super.initState();
    _resetImage();
  }

  void _resetImage() {
    // Inicializamos la URL de la imagen.
    image = 'https://i.kym-cdn.com/entries/icons/mobile/000/043/403/cover3.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images Section'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                // Reinicia el estado y regresa al home.
                _resetImage();
                Navigator.pop(context);
              },
              tooltip: 'Back to home',
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Image Section!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: image,
            ),
          ],
        ),
      ),
    );
  }
}