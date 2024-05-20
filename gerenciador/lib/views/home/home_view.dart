import 'package:flutter/material.dart';
import 'package:gerenciador/models/child_model.dart';
import 'package:gerenciador/services/children_service.dart';
import 'package:gerenciador/views/child/child_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChildrenService childrenService = ChildrenService();
  List<ChildrenModel> childrensList = [];

  @override
  void initState(){
    _updatePage();
    super.initState();
  }

  Future<void> _updatePage() async {
    try{
      List<ChildrenModel> listResponse = await childrenService.getAll();
      setState(() {
        childrensList = listResponse;
      });
    } catch (e) {
      print('Erro ao inicializar a caixa Hive: $e');
    }
  }

  @override
  void dispose() async{
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    // if (boxChildren == null) {
    //   return const CircularProgressIndicator();
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF148174),
        title: const Text("Lista de Pacientes", style: TextStyle(fontSize: 18, color: Colors.white),),
      ),
      body: Center(
        child: SizedBox(
          height: screenH,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              search(screenW),
              listPacients(screenH, screenW)
            ],
          ),
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
        color: Color(0xFF23645D),
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
      height: sH * 0.78,
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
              IconButton(onPressed: (){}, icon: const Icon(Icons.person_add, size: 25, color: Colors.black54,)),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt, size: 25, color: Colors.black54)),
              const SizedBox(width: 20,),
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_downward, size: 25, color: Colors.black54))
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
          itemCount: childrensList.length,
          itemBuilder: (_, index) {
            final ChildrenModel item = childrensList[index];
            return card(item);
          }
      ),
    );
  }

  Widget card(ChildrenModel children){
    return GestureDetector(
      onTap: () async{
        Map<String, dynamic>? result = {};

        try{
          result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChildrenPage(children: children,)));
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
          color: const Color(0xFFF6FFFE),
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
                  const SizedBox(height: 5,),
                  Text(children.name, style: const TextStyle(fontSize: 14)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Risco', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                  Text(children.risk, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

