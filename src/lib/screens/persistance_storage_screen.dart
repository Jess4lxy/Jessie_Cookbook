import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
}

class PersistanceStorageScreen extends StatefulWidget {
  const PersistanceStorageScreen({super.key});

  @override
  State<PersistanceStorageScreen> createState() =>
      _PersistenceStorageScreenState();
}

class _PersistenceStorageScreenState extends State<PersistanceStorageScreen> {
  late Database database;
  List<Dog> dogsList = [];
  int _selectedIndex = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int _counter = 0;

  final CounterStorage storage = CounterStorage();

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  // Inicializar la base de datos y cargar los perros al iniciar
  void _initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
    _loadDogs();
  }

  Future<void> _loadDogs() async {
    List<Dog> loadedDogs = await _retrieveDogs();
    setState(() {
      dogsList = loadedDogs;
    });
  }

  Future<List<Dog>> _retrieveDogs() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> _insertDog(String name, int age) async {
    final db = database;
    Dog newDog = Dog(id: 0, name: name, age: age); 
    await db.insert(
      'dogs',
      newDog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    _loadDogs();
  }

  void _addDog() {
    final String name = _nameController.text;
    final int? age = int.tryParse(_ageController.text);
    if (name.isNotEmpty && age != null) {
      _insertDog(name, age);
      _nameController.clear();
      _ageController.clear();
    }
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await storage.writeCounter(_counter); // Guardar el contador en el archivo
  }

  Widget _readAndWriteFiles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _persistDataWithSQLite() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Persisting data with SQLite',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Dog Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Dog Age',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addDog,
                child: const Text('Add Dog'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: ListView.builder(
            itemCount: dogsList.length,
            itemBuilder: (context, index) {
              final dog = dogsList[index];
              return ListTile(
                leading: Icon(Icons.pets),
                title: Text(dog.name),
                subtitle: Text('Age: ${dog.age}'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _storeKeyValueDataOnDisk() {
  return _CounterWidget();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persistence Storage'),
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
            ? _persistDataWithSQLite()
            : _selectedIndex == 2
                ? _readAndWriteFiles()
                : _selectedIndex == 3
                    ? _storeKeyValueDataOnDisk()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome to the Persistence/Storage Section!',
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
                      Navigator.pop(context);
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    tooltip: 'Back to home',
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Welcome Persistence/Storage'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Persist data with SQLite'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Read and write files'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Store key-value data on disk'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convertir un objeto Dog a un Map
  Map<String, Object?> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class _CounterWidget extends StatefulWidget {
  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _incrementCounterKey() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCounter = prefs.getInt('counter') ?? 0;
    final newCounter = currentCounter + 1;
    await prefs.setInt('counter', newCounter);
    setState(() {
      _counter = newCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Stored Counter Value:'),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: _incrementCounterKey,
            child: const Text('Increment Counter'),
          ),
        ],
      ),
    );
  }
}