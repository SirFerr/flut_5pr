import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Платформозависимое приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlatformDependentScreen()),
                );
              },
              child: const Text('Показать платформозависимый контент'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlatformDependentScreen extends StatelessWidget {
  const PlatformDependentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String platformText;
    Widget platformWidget;

    if (kIsWeb) {
      platformText = 'Вы используете Web';
      platformWidget =
          const Icon(Icons.web, size: 100, color: Colors.purpleAccent);
    } else if (Platform.isIOS) {
      platformText = 'Вы используете iOS';
      platformWidget =
          const Icon(Icons.phone_iphone, size: 100, color: Colors.blue);
    } else if (Platform.isWindows) {
      platformText = 'Вы используете Windows';
      platformWidget = const Icon(Icons.home, size: 100, color: Colors.orange);
    } else if (Platform.isMacOS) {
      platformText = 'Вы используете macOS';
      platformWidget =
          const Icon(Icons.laptop_mac, size: 100, color: Colors.grey);
    } else if (Platform.isLinux) {
      platformText = 'Вы используете Linux';
      platformWidget = const Icon(Icons.laptop, size: 100, color: Colors.red);
    } else if (Platform.isAndroid) {
      platformText = 'Вы используете Android';
      platformWidget =
          const Icon(Icons.android, size: 100, color: Colors.green);
    } else {
      platformText = 'Неизвестная платформа';
      platformWidget =
          const Icon(Icons.device_unknown, size: 100, color: Colors.black);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Платформозависимый экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              platformText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            platformWidget,
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (kIsWeb) {
                  html.window.navigator.clipboard!.writeText('Это текст для копирования');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Это действие специфично для ${Platform.operatingSystem}'),
                    ),
                  );
                }
              },
              child: const Text('Выполнить платформозависимое действие'),
            ),
          ],
        ),
      ),
    );
  }
}
