import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GraphicsView extends StatefulWidget {
  const GraphicsView({super.key});

  @override
  State<GraphicsView> createState() => _GraphicsViewState();
}

class _GraphicsViewState extends State<GraphicsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('GraphicsView'),
      ),
    );
  }
}
