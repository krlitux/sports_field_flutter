import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/login_request_model.dart';
import 'package:sports_field_app/presentation/pages/proveedor_home_page.dart';
import 'package:sports_field_app/presentation/pages/jugador_home_page.dart';
import 'package:sports_field_app/presentation/features/auth/provider/auth_repository_provider.dart';
import 'package:sports_field_app/presentation/widgets/rounded_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool cargando = false;
  String? error;

  Future<void> login() async {
    setState(() {
      cargando = true;
      error = null;
    });

    final authRepo = ref.read(authRepositoryProvider);

    final loginRequest = LoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      // Intentamos como jugador primero
      await authRepo.login(loginRequest, 'jugador');
    } catch (_) {
      try {
        // Si falla, intentamos como proveedor
        await authRepo.login(loginRequest, 'proveedor');
      } catch (_) {
        setState(() {
          cargando = false;
          error = 'Credenciales inválidas o error de conexión.';
        });
        return;
      }
    }

    final tipo = await authRepo.getTipoUsuario();

    if (!mounted) return;

    switch (tipo) {
      case 'jugador':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const JugadorHomePage()),
        );
        break;
      case 'proveedor':
        Navigator.pushReplacement(
            context,
          MaterialPageRoute(builder: (_) => const ProveedorHomePage()),
        );
        break;
      default:
        error = 'Tipo de usuario no reconocido.';
    }

    setState(() => cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            RoundedButton(
              text: cargando ? 'Ingresando...' : 'Ingresar',
              onPressed: cargando ? null : login,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
