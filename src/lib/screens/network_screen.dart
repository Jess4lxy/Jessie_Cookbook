import 'package:flutter/material.dart';
import 'long_list.dart';  // Asegúrate de importar la clase LongList

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
        title: const Text('Networking'),
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
        child: _selectedIndex == 0
            ? const LongList() // Aquí se inserta LongList para traer los datos
            : _selectedIndex == 1
                ? _makeAuthenticatedRequests()
                : _selectedIndex == 2
                    ? _sendDataToInternet()
                    : _selectedIndex == 3
                        ? _updateDataOverInternet()
                        : _selectedIndex == 4
                            ? _deleteDataOnInternet()
                            : _selectedIndex == 5
                                ? _communicateWithWebSockets()
                                : _parseJsonInBackground(),
      ),
      drawer: Drawer(
        child: ListView(
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
                    },
                    tooltip: 'Back to home',
                  ),
                ],
              ),
            ),
            _buildDrawerItem('Fetch data from the internet', 0),
            _buildDrawerItem('Make authenticated requests', 1),
            _buildDrawerItem('Send data to the internet', 2),
            _buildDrawerItem('Update data over the internet', 3),
            _buildDrawerItem('Delete data on the internet', 4),
            _buildDrawerItem('Communicate with WebSockets', 5),
            _buildDrawerItem('Parse JSON in the background', 6),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(String title, int index) {
    return ListTile(
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }

  Widget _makeAuthenticatedRequests() {
    return const Placeholder(
      fallbackHeight: 200,
      color: Colors.greenAccent,
    );
  }

  Widget _sendDataToInternet() {
    return const Placeholder(
      fallbackHeight: 200,
      color: Colors.orangeAccent,
    );
  }

  Widget _updateDataOverInternet() {
    return const Placeholder(
      fallbackHeight: 200,
      color: Colors.purpleAccent,
    );
  }

  Widget _deleteDataOnInternet() {
    return const Placeholder(
      fallbackHeight: 200,
      color: Colors.redAccent,
    );
  }

  Widget _communicateWithWebSockets() {
    return const Placeholder(
      fallbackHeight: 200,
      color: Colors.tealAccent,
    );
  }

  Widget _parseJsonInBackground() {
    return const Placeholder(
      fallbackHeight: 200,
      color: Colors.yellowAccent,
    );
  }
}
