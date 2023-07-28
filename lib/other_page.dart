import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Other Page'),
      ),
      body: const Center(
        child: Text(
          'Other Page',
          style: TextStyle(fontSize: 52.0),
        ),
      ),
    );
  }
}
