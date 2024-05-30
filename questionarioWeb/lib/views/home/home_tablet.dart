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
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 600,
            child: Column(
              children: [
                Text('Escala M-CHAT: a principal escala de rastreio para autismo\n A M-CHAT é uma escala de rastreio que pode ser utilizada em todas as crianças com idade entre 16 e 30 meses com objetivo de identificar precocemente riscos para autismo.\n',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 14)
                ),
                Text('IMPORTANTE: a aplicação da M-CHAT não substitui uma avaliação diagnóstica feita por um médico e por uma equipe multidisciplinar especializada. Seu uso deve ser feito somente para confirmar algumas suspeitas e a partir dai procurar ajuda profissional.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)
                ),
              ],
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

