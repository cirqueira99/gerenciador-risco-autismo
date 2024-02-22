import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Home", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Center(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: Text("datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata"),
              ),
              SizedBox(child: Image.asset('lib/assets/imagem_inicial.jpg', width: 300,)),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: ()=>{
                      Navigator.pushNamed(context, '/questionario')
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                            child: const Icon(Icons.double_arrow, size: 16, color: Colors.white)
                        ),
                        const Text("Começar", style: TextStyle(fontSize: 16, color: Colors.white))
                      ],
                    )
                )
              )
            ],
          ),
        )
      ),
    );
  }
}

