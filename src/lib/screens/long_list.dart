import 'package:flutter/material.dart';
import '../functions/api_service.dart'; // Importa el archivo de conexión

class LongList extends StatefulWidget {
  const LongList({super.key});

  @override
  LongListState createState() => LongListState();
}

class LongListState extends State<LongList> {
  final ApiService _apiService = ApiService();
  final List<dynamic> _users = []; // Lista de usuarios
  bool _isLoading = false; // Indicador de carga
  bool _hasMore = true; // Flag para saber si hay más datos
  int _page = 1; // Página actual para la paginación
  final int _limit = 10; // Número de usuarios por página
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();

    // Listener para detectar cuando se llega al final de la lista
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _fetchUsers();
      }
    });
  }

  Future<void> _fetchUsers() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Inicia sesión
      await _apiService.login('string', 'string'); // Cambia las credenciales

      // Obtiene usuarios para la página actual
      final users = await _apiService.fetchAllUsers(limit: _limit, page: _page);

      setState(() {
        if (users.isEmpty) {
          _hasMore = false; // No hay más datos por cargar
        } else {
          _users.addAll(users);
          _page++; // Incrementa la página para futuras solicitudes
        }
      });
    } catch (error) {
      debugPrint('Error al cargar usuarios: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Long List'),
      ),
      body: _users.isEmpty
          ? _isLoading
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: Text('No hay usuarios disponibles.'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: _users.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _users.length) {
                  // Indicador de carga al final
                  return const Center(child: CircularProgressIndicator());
                }

                final user = _users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        user['foto'] ?? 'https://via.placeholder.com/150'),
                  ),
                  title: Text(user['name'] ?? 'Sin nombre'),
                  subtitle: Text(
                      "Comida favorita: ${user['comidaFavorita'] ?? 'No especificado'}"),
                  trailing: Text("ID: ${user['_id'] ?? 'N/A'}"),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
