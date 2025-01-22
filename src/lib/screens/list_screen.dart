import 'package:flutter/material.dart';

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