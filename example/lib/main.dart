import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

void main() {

  Client.instance.initialize(
    endPoint: 'https://192.168.178.192/v1',
    projectId: '5f6d7e2e0d0a2',
    selfSigned: true, // Use in development only
  );

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppWrite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text('Welcome to AppWrite')
        ),
      ),
    );
  }
}