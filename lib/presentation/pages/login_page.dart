import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/login_request_model.dart';
import 'package:sports_field_app/presentation/pages/home_page.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';
import '../../main.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String tipo = 'jugador'; // o 'proveedor'
  bool loading = false;
  String? error;

  void login() async {
    setState(() {
      loading = true;
      error = null;
    });

    final authRepo = ref.read(authRepositoryProvider);
    final request = LoginRequestModel(
      email: _emailController.text,
      password: _passController.text,
    );

    try {
      await authRepo.login(request, tipo);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MyApp()), // fuerza reinicio de flujo
            (_) => false,
      );
    } catch (e) {
      setState(() {
        error = 'Credenciales inválidas';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: tipo,
              items: const [
                DropdownMenuItem(value: 'jugador', child: Text('Jugador')),
                DropdownMenuItem(value: 'proveedor', child: Text('Proveedor')),
              ],
              onChanged: (val) => setState(() => tipo = val!),
            ),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : login,
              child: loading ? const CircularProgressIndicator() : const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
