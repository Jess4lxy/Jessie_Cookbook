import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _animateWidgetAcrossScreens() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const DetailScreen();
        }));
      },
      child: Hero(
        tag: 'imageHero',
        child: Center(
          child: Image.network(
            'https://i.kym-cdn.com/entries/icons/mobile/000/041/444/sdc.jpg',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }

  Widget _navigateToANewScreenAndBack() {
    return ElevatedButton(
      child: const Text('Open route'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecondRoute()),
        );
      },
    );
  }

  Widget _returnDataFromAScreen() {
    return ElevatedButton(
      onPressed: () {
        _navigateAndReturnData(context);
      },
      child: const Text('Return some data!'),
    );
  }

  Future<void> _navigateAndReturnData(BuildContext context) async {
    // Lanza la pantalla que devuelve datos usando Navigator.push
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DataReturnScreen()),
    );

    // Asegurarse de que el contexto esté montado antes de mostrar el resultado
    if (!context.mounted) return;

    // Mostrar el resultado con un SnackBar
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Returned data: $result')));
  }

  Widget _sendDataToANewScreen() {
    return ElevatedButton(
      onPressed: () {
        _navigateAndSendData(context);
      },
      child: const Text('Send Data to New Screen'),
    );
  }

  Future<void> _navigateAndSendData(BuildContext context) async {
    // Crear distintas opciones de datos
    final options = [
      Todo(title: 'Buy groceries', description: 'Milk, eggs, and bread'),
      'This is a simple string data',
      42, // Un número
    ];

    // Selecciona una opción aleatoria de la lista
    final selectedData =
        options[0]; // Cambia el índice para probar con diferentes datos

    // Lanza la pantalla de destino y pasa el objeto seleccionado
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewScreen(),
        settings: RouteSettings(
          arguments:
              selectedData, // Pasa el objeto seleccionado a la nueva pantalla
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Section'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _selectedIndex == 1
            ? _animateWidgetAcrossScreens() // Llamada a la función de animación
            : _selectedIndex == 2
                ? _navigateToANewScreenAndBack()
                : _selectedIndex == 3
                    ? _returnDataFromAScreen()
                    : _selectedIndex == 4
                        ? _sendDataToANewScreen()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Welcome to the Navigation Section!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Select any option from the Drawer.',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Drawer Header',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Cierra el Drawer
                      Navigator.popUntil(context,
                          ModalRoute.withName('/')); // Cierra el Drawer
                    },
                    tooltip: 'Back to home',
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Welcome Navigation'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Animate a widget across screens'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Navigate to a new screen and back'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Return data from a screen'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Send data to a new screen'),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de detalle donde se recibe la animación
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Volver a la pantalla anterior
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'imageHero', // Mismo tag para la transición
                child: Image.network(
                  'https://i.kym-cdn.com/entries/icons/mobile/000/041/444/sdc.jpg', // Imagen que se anima
                  width: 300, // Tamaño de la imagen
                  height: 300,
                ),
              ),
              const SizedBox(height: 10), // Espaciado entre imagen y texto
              const Text(
                'womp womp', // Texto debajo de la imagen
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class DataReturnScreen extends StatelessWidget {
  const DataReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Data Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Cierra la pantalla y devuelve "Success!" como resultado
                  Navigator.pop(context, 'Success!');
                },
                child: const Text('Success!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Cierra la pantalla y devuelve "Failure." como resultado
                  Navigator.pop(context, 'Failure.');
                },
                child: const Text('Failure.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo({
    required this.title,
    required this.description,
  });
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recupera el argumento que fue pasado al navegar
    final dynamic data = ModalRoute.of(context)!.settings.arguments;

    // Verifica qué tipo de datos fue recibido y maneja según el tipo
    String displayText = '';

    if (data is Todo) {
      displayText = 'Title: ${data.title}\nDescription: ${data.description}';
    } else if (data is String) {
      displayText = 'String Data: $data';
    } else if (data is int) {
      displayText = 'Integer Data: $data';
    } else {
      displayText = 'Unknown Data';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          displayText,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
