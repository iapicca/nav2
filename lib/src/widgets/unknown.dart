import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen() : super(key: const Key('UnknownScreen'));
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('404!')),
      );
}
