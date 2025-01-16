import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
          ],
        ),
      ),
    );
  }
}

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hello from the SnackBar!'),
      ),
    );
  }

  Widget _buildGridView() {
    return OrientationBuilder(
      builder: (context, orientation) {
        int columns = orientation == Orientation.portrait ? 2 : 3;
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 1.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  'Item $index',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTabScaffold() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tabs Example"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Section'),
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
            ? _buildGridView()
            : _selectedIndex == 2
                ? _buildTabScaffold()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome to the Design Section!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () => _showSnackBar(context),
                        child: const Text('Show SnackBar'),
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
              title: const Text('Welcome Snackbar'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('GridView with Orientation'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Work with Tabs'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHorizontalList() {
    return SizedBox(
      height: 200, // Ajusta la altura según necesites
      child: Scrollbar(
        controller: ScrollController(), // Controlador para el scroll
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 100, // Número de elementos en la lista
          physics: const BouncingScrollPhysics(), // Física del desplazamiento
          itemBuilder: (context, index) {
            return Container(
              width: 150, // Ancho de cada elemento
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListWithDifferentItems() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text('Person $index'),
            subtitle: const Text('This is a description'),
            trailing: const Icon(Icons.arrow_forward),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Custom Widget $index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildFloatingAppBarAboveList() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: Placeholder(),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text('Item #$index')),
            childCount: 50,
          ),
        )
      ],
    );
  }

  Widget _buildUsingLists() {
    return ListView(
      children: const <Widget>[
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),
      ],
    );
  }

  Widget _buildWorkingLongLists() {
    final items = List<String>.generate(10000, (i) => 'Item $i');

    return ListView.builder(
      itemCount: items.length,
      prototypeItem: ListTile(
        title: Text(items.first),
      ),
      itemBuilder: (context, index) {
        return ListTile(title: Text(items[index]));
      },
    );
  }

  Widget _buildCreateListWithSpacedItems() {
    const items = 20;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                items,
                (index) => _buildItemWidget('Item $index'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemWidget(String text) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Center(
          child: Text(text),
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
            ? _buildHorizontalList()
            : _selectedIndex == 2
                ? _buildListWithDifferentItems()
                : _selectedIndex == 3
                    ? _buildFloatingAppBarAboveList()
                    : _selectedIndex == 4
                        ? _buildUsingLists()
                        : _selectedIndex == 5
                            ? _buildWorkingLongLists()
                            : _selectedIndex == 6
                                ? _buildCreateListWithSpacedItems()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Welcome to the List Section!',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 16), // Espaciado entre textos
                                      const Text(
                                        'Here you have an easy Grid List:',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              16), // Espaciado entre texto y GridView
                                      Expanded(
                                        // Expande el GridView para ocupar el espacio restante
                                        child: GridView.count(
                                          crossAxisCount:
                                              2, // Número de columnas
                                          crossAxisSpacing:
                                              8.0, // Espaciado horizontal entre celdas
                                          mainAxisSpacing:
                                              8.0, // Espaciado vertical entre celdas
                                          padding: const EdgeInsets.all(
                                              8.0), // Padding alrededor del GridView
                                          children: List.generate(100, (index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Item $index',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            );
                                          }),
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
              title: const Text('Welcome Grid List'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Horizontal List'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('List With Different Items'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('List With Floating App Bar'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Using Lists'),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Working With Long Lists'),
              selected: _selectedIndex == 5,
              onTap: () {
                _onItemTapped(5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Create A List With Spaced Items'),
              selected: _selectedIndex == 6,
              onTap: () {
                _onItemTapped(6);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _carreraController = TextEditingController();
  final TextEditingController _cuatrimestreController = TextEditingController();
  final TextEditingController _periodoController = TextEditingController();

  String _submittedData = '';

  @override
  void dispose() {
    _nameController.dispose();
    _matriculaController.dispose();
    _carreraController.dispose();
    _cuatrimestreController.dispose();
    _periodoController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedData = '''
Nombre: ${_nameController.text}
Matrícula: ${_matriculaController.text}
Carrera: ${_carreraController.text}
Cuatrimestre: ${_cuatrimestreController.text}
Periodo: ${_periodoController.text}
        ''';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos enviados correctamente')),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Name',
                  controller: _nameController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter your name' : null,
                  icon: Icons.person,
                ),
                _buildTextField(
                  label: 'ID',
                  controller: _matriculaController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter your identification'
                      : null,
                  icon: Icons.school,
                ),
                _buildTextField(
                  label: 'Program',
                  controller: _carreraController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter your program'
                      : null,
                  icon: Icons.book,
                ),
                _buildTextField(
                  label: 'Semester',
                  controller: _cuatrimestreController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your current semester';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Only numbers are accepted';
                    }
                    return null;
                  },
                  icon: Icons.timeline,
                ),
                _buildTextField(
                  label: 'Term',
                  controller: _periodoController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter your current term'
                      : null,
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 20),
                if (_submittedData.isNotEmpty)
                  Text(
                    'Data submitted:\n$_submittedData',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
      42,  // Un número
    ];

    // Selecciona una opción aleatoria de la lista
    final selectedData = options[0];  // Cambia el índice para probar con diferentes datos

    // Lanza la pantalla de destino y pasa el objeto seleccionado
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewScreen(),
        settings: RouteSettings(
          arguments: selectedData,  // Pasa el objeto seleccionado a la nueva pantalla
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
            ? _animateWidgetAcrossScreens()  // Llamada a la función de animación
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
                      Navigator.popUntil(context, ModalRoute.withName('/')); // Cierra el Drawer
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
                  'https://i.kym-cdn.com/entries/icons/mobile/000/041/444/sdc.jpg',  // Imagen que se anima
                  width: 300, // Tamaño de la imagen
                  height: 300,
                ),
              ),
              const SizedBox(height: 10),  // Espaciado entre imagen y texto
              const Text(
                'womp womp',  // Texto debajo de la imagen
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
