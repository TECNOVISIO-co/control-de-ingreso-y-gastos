# Documentación para desarrolladores

## Estructura del proyecto

El proyecto está organizado de la siguiente manera:

- `lib/`: Contiene todo el código fuente de la aplicación.
    - `models/`: Definiciones de los modelos de datos.
    - `providers/`: Proveedores de estado utilizando el patrón Provider.
    - `screens/`: Pantallas principales de la aplicación.
    - `services/`: Servicios para manejar la lógica de negocio.
    - `utils/`: Utilidades y helpers.
    - `widgets/`: Widgets reutilizables.

## Configuración del entorno de desarrollo

1. Instala Flutter siguiendo las instrucciones oficiales: https://flutter.dev/docs/get-started/install
2. Clona este repositorio.
3. Ejecuta `flutter pub get` para instalar las dependencias.
4. Configura los emuladores o dispositivos físicos para las plataformas que deseas probar.

## Compilación y ejecución

- Para ejecutar la aplicación en modo debug: `flutter run`
- Para compilar la aplicación para Android: `flutter build apk`
- Para compilar la aplicación para iOS: `flutter build ios`
- Para compilar la aplicación web: `flutter build web`

## Pruebas

- Para ejecutar las pruebas unitarias: `flutter test`
- Para ejecutar las pruebas de integración: `flutter drive --target=test_driver/app.dart`

## Contribución

1. Crea una nueva rama para tu función o corrección de errores.
2. Realiza tus cambios y asegúrate de que todas las pruebas pasen.
3. Crea un pull request con una descripción detallada de tus cambios.

## Recursos adicionales

- [Documentación de Flutter](https://flutter.dev/docs)
- [Pub.dev (paquetes de Dart y Flutter)](https://pub.dev/)