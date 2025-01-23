import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  final Dio _dio;
  String? _authToken;
  final Logger _logger = Logger();

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://api-soonwe-blue.onrender.com/",
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Accept': 'application/json',
            },
          ),
        );

  // Método para iniciar sesión
  Future<void> login(String user_name, String password) async {
    try {
      final response = await _dio.post(
        "/users/login",
        data: {
          "user_name": user_name,
          "password": password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      _authToken = response.data['token'];
      _dio.options.headers['Authorization'] = "Bearer $_authToken";
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _logger.e("Error de conexión: No se pudo establecer conexión");
      } else if (e.type == DioExceptionType.sendTimeout) {
        _logger.e("Error de tiempo de envío: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _logger.e("Error de tiempo de recepción: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.cancel) {
        _logger.e("Error de solicitud cancelada");
      } else {
        _logger.e("Error inesperado: $e");
      }
      throw Exception("Error al iniciar sesión: $e");
    }
  }

  // Método para obtener todos los usuarios con paginado
  Future<List<dynamic>> fetchAllUsers({int limit = 10, int page = 1}) async {
    if (_authToken == null) {
      throw Exception("No has iniciado sesión");
    }

    List<dynamic> allUsers = [];

    try {
      final response = await _dio.get(
        "/users",
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      _logger.d("Response data: ${response.data}");

      final users = response.data['users'];
      allUsers.addAll(users);

      final total = response.data['total'];
      final totalPages = (total / limit).ceil();

      if (page >= totalPages) {
        _logger.d("No hay más páginas");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _logger.e("Error de conexión: No se pudo establecer conexión");
      } else if (e.type == DioExceptionType.sendTimeout) {
        _logger.e("Error de tiempo de envío: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _logger.e("Error de tiempo de recepción: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.cancel) {
        _logger.e("Error de solicitud cancelada");
      } else {
        _logger.e("Error inesperado: $e");
      }
      throw Exception("Error al obtener usuarios: $e");
    } catch (e) {
      _logger.e("Error desconocido: $e");
      throw Exception("Error al obtener usuarios: $e");
    }

    return allUsers;
  }

  // Método para agregar un nuevo usuario
  Future<void> addUser({
    required String name,
    required String userName,
    required String password,
    required String foto,
    required String verificado,
  }) async {
    if (_authToken == null) {
      throw Exception("No has iniciado sesión");
    }

    try {
      final response = await _dio.post(
        "/users",
        data: {
          "name": name,
          "user_name": userName,
          "password": password,
          "foto": foto,
          "verificado": verificado,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $_authToken",
          },
        ),
      );

      _logger.d("Usuario agregado: ${response.data}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _logger.e("Error de conexión: No se pudo establecer conexión");
      } else if (e.type == DioExceptionType.sendTimeout) {
        _logger.e("Error de tiempo de envío: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _logger.e("Error de tiempo de recepción: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.cancel) {
        _logger.e("Error de solicitud cancelada");
      } else {
        _logger.e("Error inesperado: $e");
      }
      throw Exception("Error al agregar usuario: $e");
    }
  }

  // Método para editar un usuario
  Future<void> editUser({
    required String userId,
    required String name,
    required String userName,
    required String password,
    required String foto,
    required String verificado,
  }) async {
    if (_authToken == null) {
      throw Exception("No has iniciado sesión");
    }

    try {
      final response = await _dio.put(
        "/users/$userId",  // URL dinámica para editar un usuario por ID
        data: {
          "name": name,
          "user_name": userName,
          "password": password,
          "foto": foto,
          "verificado": verificado,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $_authToken",
          },
        ),
      );

      _logger.d("Usuario editado: ${response.data}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _logger.e("Error de conexión: No se pudo establecer conexión");
      } else if (e.type == DioExceptionType.sendTimeout) {
        _logger.e("Error de tiempo de envío: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _logger.e("Error de tiempo de recepción: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.cancel) {
        _logger.e("Error de solicitud cancelada");
      } else {
        _logger.e("Error inesperado: $e");
      }
      throw Exception("Error al editar usuario: $e");
    }
  }

  // Método para eliminar un usuario
  Future<void> deleteUser(String userId) async {
    if (_authToken == null) {
      throw Exception("No has iniciado sesión");
    }

    try {
      final response = await _dio.delete(
        "/users/$userId",  // URL dinámica para eliminar un usuario por ID
        options: Options(
          headers: {
            'Authorization': "Bearer $_authToken",
          },
        ),
      );

      _logger.d("Usuario eliminado: ${response.data}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _logger.e("Error de conexión: No se pudo establecer conexión");
      } else if (e.type == DioExceptionType.sendTimeout) {
        _logger.e("Error de tiempo de envío: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        _logger.e("Error de tiempo de recepción: Tiempo de espera agotado");
      } else if (e.type == DioExceptionType.cancel) {
        _logger.e("Error de solicitud cancelada");
      } else {
        _logger.e("Error inesperado: $e");
      }
      throw Exception("Error al eliminar usuario: $e");
    }
  }
}
