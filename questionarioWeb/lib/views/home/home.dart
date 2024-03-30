import 'package:flutter/material.dart';
import 'package:questionario/views/home/home_desktop.dart';
import 'package:questionario/views/home/home_mobile.dart';
import 'package:questionario/views/home/home_tablet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Home", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          if(constraints.maxWidth < 510){
            return const HomePageMobile();
          }else if(constraints.maxWidth < 1100){
            return const HomePageTablet();
          }else {
            return const HomePageDesktop();
          }
        }),
      ),
    );
  }
}

