import 'package:flutter/material.dart';
import 'package:gerenciador/views/child/child_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pacientes = [
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'},
    {'risco': 'Alto', 'nome': 'Pedro Henrique da Silva', 'responsavel': 'Robertas Silva'}
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Lista de Pacientes", style: TextStyle(fontSize: 18, color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            search(screenW),
            listPacients(screenH, screenW)
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.deepPurple,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.clear, color: Colors.transparent),
      //       label: 'Tab 1',
      //       backgroundColor: Colors.grey, // Cor de fundo do item
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.clear, color: Colors.transparent),
      //       label: 'Tab 1',
      //       backgroundColor: Colors.grey, // Cor de fundo do item
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  Widget search(num sW){
    return Container(
      height: 40,
      width: sW * 0.9,
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Cor de fundo cinza
        border: Border.all(color: Colors.grey.shade100), // Borda cinza
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 5),
            child: Icon(Icons.search),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar paciente...',
                counterStyle: TextStyle(fontSize: 12),
                border: InputBorder.none
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listPacients(num sH, num sW){

    return SizedBox(
      height: sH * 0.82,
      width: sW * 0.9,
      child: Column(
        children: [
          filter(),
          list(sH)
        ],
      ),
    );
  }

  Widget filter(){
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.list))
        ],
      ),
    );
  }

  Widget list(num sH){
    return SizedBox(
      height: sH * 0.70,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: pacientes.length,
          itemBuilder: (_, index) {
            final Map<String, dynamic> item = pacientes[index];
            return card(item);
          }
      ),
    );
  }

  Widget card(Map<String, dynamic> p){
    return GestureDetector(
      onTap: () async{
        Map<String, dynamic> result = {};
        try{
          result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChildrenPage()));
        }catch(error){
          throw Exception(error);
        }finally{
          //if(result.isNotEmpty) SnackBarNotify.createSnackBar(context, result);

          //widget.refresh(DateFormat('dd/MM/yyyy').format(widget.dateToday));
        }
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(15),
        margin:  const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(2, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Nome criança: ', style: TextStyle(fontSize: 12)),
                      Text(p['nome'], style: const TextStyle(fontSize: 14))
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Responsável: ', style: TextStyle(fontSize: 12)),
                      Text(p['responsavel'], style: const TextStyle(fontSize: 14))
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(p['risco'], style: const TextStyle(fontSize: 16), textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}

