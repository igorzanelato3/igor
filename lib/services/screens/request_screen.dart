import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  RequestScreenState createState() => RequestScreenState();
}

class RequestScreenState extends State<RequestScreen> {
  bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: _isEmailValid ? null : 'Email inválido',
          ),
          onChanged: (value) {
            setState(() {
              _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
            });
          },
        ),
      ),
    );
  }
}