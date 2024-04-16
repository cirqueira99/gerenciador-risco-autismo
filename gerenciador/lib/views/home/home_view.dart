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
        backgroundColor: const Color(0xFF703296),
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
      height: 90,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF501873),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: sW * 0.9,
            //padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(10),
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
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Pesquisar paciente...',
                        counterStyle: TextStyle(fontSize: 10),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listPacients(num sH, num sW){

    return SizedBox(
      height: sH * 0.80,
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
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200, width: 2.0
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.person_add, size: 30, color: Colors.black54,)),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt, size: 30, color: Colors.black54)),
              SizedBox(width: 20,),
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_downward, size: 30, color: Colors.black54))
            ],
          )
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
        padding: const EdgeInsets.all(10),
        margin:  const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF6EEFF),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 4,
              offset: const Offset(2, 2),
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
                  const Text('Nome da criança: ', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 5,),
                  Text(p['nome'], style: const TextStyle(fontSize: 14)),
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

