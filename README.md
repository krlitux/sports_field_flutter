# ⚽ Sports Field App (Flutter)

Aplicación móvil para reservar canchas deportivas y gestionar campos, desarrollada con Flutter. Forma parte del MVP del proyecto Sports Field, en conjunto con el backend Node.js + Sequelize.

## 📱 Características principales
### 👤 Jugador
- Registro e inicio de sesión
- Explorar canchas disponibles
- Reservar una cancha (fecha + hora)
- Ver historial de reservas
- Cancelar reservas con anticipación

### 🏟️ Proveedor
- Login con credenciales de proveedor
- Crear nuevas canchas
- Editar o eliminar canchas propias
- Ver reservas realizadas por jugadores

## 🛠️ Tecnologías
- ✅ Flutter 3.22
- ✅ Riverpod (gestión de estado)
- ✅ Dio (peticiones HTTP)
- ✅ Flutter Secure Storage (token JWT seguro)
- ✅ Material 3 y UI moderna
- 🔐 Autenticación JWT
- 📶 Conectividad vía REST API

## 🚀 Instalación y ejecución
### 🔧 Requisitos previos
- Android Studio con Flutter configurado
- Java SDK 17 o superior
- Emulador de Android (o dispositivo físico)
- Backend corriendo localmente (ver más abajo)

### ▶️ Pasos para correr la app
```bash
git clone https://github.com/krlitux/sports_field_flutter.git
cd sports_field_flutter
flutter pub get
flutter run
```

## 🔗 Conexión al backend
El archivo lib/presentation/providers/auth_provider.dart incluye:

```dart
baseUrl: 'http://10.0.2.2:3000', // Para Android Emulator
Si usas dispositivo físico o IP diferente, ajusta la dirección según sea necesario.
```

## 📦 Estructura del proyecto
```bash
/lib
├── data
│   ├── clients/           # Cliente Dio autenticado
│   ├── models/            # Modelos de datos
│   └── repositories/      # Acceso a la API
├── presentation
│   ├── pages/             # Pantallas principales
│   ├── providers/         # Riverpod: lógica y estados
│   └── widgets/           # Widgets reutilizables (a futuro)
```

## ✅ Estado actual
| Funcionalidad                      | Estado             |
|------------------------------------|--------------------|
| Login jugador | 	✅ Completo        |
| Login proveedor | 	✅ Completo        |
| Crear cancha | 	✅ Completo        |
| Reservar cancha | 	✅ Completo        |
| Ver mis reservas | 	✅ Completo        |
| Ver reservas como proveedor        | 	✅ Completo        |
| Cancelar reserva | 	✅ Completo        |
| UI/UX MVP | 	✅ Aplicado        |
| Login admin | 	🚧 Versión futura |
| Pagos (Yape, QR) | 	🚧 Versión futura |

## 📅 Próximas versiones
### Versión 1.1 incluirá:
- Canchas favoritas
- Suspensión temporal de canchas
- Mejores filtros de búsqueda
- Dashboard para administrador
- Notificaciones push básicas

## ✨ Créditos
Desarrollado con ❤️ por @krlitux como parte del MVP Sports Field.