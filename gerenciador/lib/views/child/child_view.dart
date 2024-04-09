import 'package:flutter/material.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Children", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: const Center(
        child: Text("Criança"),
      ),
    );
  }
}

