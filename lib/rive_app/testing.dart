import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() {
    // TODO: implement createState
    return _TestingState();
  }
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: const Center(
        child: const Column(
          children: [
            Text('hello world'),
          ],
        ),
      ),
    );
  }
}
