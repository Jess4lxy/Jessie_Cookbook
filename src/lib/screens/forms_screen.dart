import 'package:flutter/material.dart';

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