import 'package:flutter/material.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({super.key});

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 350,
            child: Text("datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 14)
            ),
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
    );
  }
}

