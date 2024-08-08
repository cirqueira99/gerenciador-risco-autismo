import 'package:flutter/material.dart';
import 'package:gerenciador/models/child_model.dart';
import 'package:gerenciador/services/children_service.dart';
import 'package:gerenciador/views/child/child_view.dart';

import '../../shared/snackbar_notify.dart';
import '../child/child_add.dart';
import '../child/filter_childrens.dart';
import '../child/order_childrens.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChildrenService childrenService = ChildrenService();
  List<ChildrenModel> childrenList = [];
  List<ChildrenModel> childrenListAux = [];
  OrderChildrens orderChildrens = OrderChildrens();
  FilterChildrens filterChildrens = FilterChildrens();
  String orderCurrent = '1';
  Map<String, dynamic> optionsFilter = {
    'checkedOptions': {
      'checkedResetFilters': true,
      'checkedEmpty': false,
      'checkedSmall': false,
      'checkedMedium': false,
      'checkedTall': false
    }
  };

  @override
  void initState(){
    _refreshPage();
    super.initState();
  }

  Future<void> _refreshPage() async {
    try{
      List<ChildrenModel> listResponse = await childrenService.getAll();

      setState(() {
        childrenList = listResponse;
        childrenListAux = orderChildrens.executeOrder(childrenList, '1');
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
      height: 60,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
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
              IconButton(
                  style: IconButton.styleFrom(backgroundColor: const Color(0xFF66A49C)),
                  onPressed: () async{
                    Map<String, dynamic>? resultChildrenPage = {};

                    try{
                      resultChildrenPage = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ChildrenAdd(edit: false, childrenModel: ChildrenModel(name: "", dataNasc: "00/00/0000", sex: "", responsible: "", risk: "", punctuation: 0.0)),
                          )
                      );
                      if(resultChildrenPage != null && resultChildrenPage.isNotEmpty){
                        SnackbarNotify.createSnackBar(context, resultChildrenPage);
                      }
                    }catch(error){
                      throw Exception(error);
                    }finally{
                      _refreshPage();
                    }
                  },
                  icon: const Icon(Icons.person_add, size: 20, color: Colors.white,)
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                style: orderCurrent == '1'? IconButton.styleFrom(backgroundColor: const Color(0xFF66A49C)) : IconButton.styleFrom(backgroundColor: const Color(0xFF23645D)),
                onPressed: () async {
                  Map<String, dynamic> optionOrderResponse = { };

                  try{
                    optionOrderResponse = await orderChildrens.exibirModalDialog(context, childrenListAux, orderCurrent);

                    if(optionOrderResponse['execute'] == true){
                      setState(() {
                        childrenListAux = optionOrderResponse['newChildrenList'];
                        orderCurrent = optionOrderResponse['optionOrder'];
                      });
                    }
                  }catch(error){
                    throw Exception(error);
                  }
                },
                icon: const Icon(Icons.swap_vert, size: 25, color: Colors.white)
              ),
              const SizedBox(width: 20,),
              IconButton(
                  style: IconButton.styleFrom(backgroundColor: optionsFilter['checkedOptions']['checkedResetFilters']?  const Color(0xFF66A49C): const Color(0xFF23645D)),
                  onPressed: () async {
                    Map<String, dynamic> optionsFilterResponse = {};

                    try{
                      optionsFilterResponse = await filterChildrens.exibirModalDialog(context, childrenList, optionsFilter);

                      if(optionsFilterResponse['execute'] == true){
                        if(optionsFilterResponse['checkedOptions']['checkedResetFilters']){
                          setState(() {
                            childrenListAux = childrenList;
                            optionsFilter['checkedOptions'] =  { 'checkedResetFilters': true, 'checkedEmpty': false, 'checkedSmall': false, 'checkedMedium': false,'checkedTall': false };
                          });
                        }else{
                          setState(() {
                            childrenListAux = optionsFilterResponse['newChildrenList'];
                            optionsFilter['checkedOptions'] = optionsFilterResponse['checkedOptions'];
                          });
                        }
                      }
                    }catch(error){
                      throw Exception(error);
                    }
                  },
                  icon: optionsFilter['checkedOptions']['checkedResetFilters']? const Icon(Icons.filter_alt, size: 20, color: Colors.white) : const Icon(Icons.filter_alt, size: 20, color: Colors.white)
              ),
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
          itemCount: childrenListAux.length,
          itemBuilder: (_, index) {
            final ChildrenModel item = childrenListAux[index];
            return card(item);
          }
      ),
    );
  }

  Widget card(ChildrenModel children){

    return GestureDetector(
      onTap: () async{
        Map<String, dynamic>? resultChidrenPage = {};

        try{
          resultChidrenPage = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChildrenPage(children: children)));

          if(resultChidrenPage != null && resultChidrenPage.isNotEmpty){
            SnackbarNotify.createSnackBar(context, resultChidrenPage);
          }
        }catch(error){
          throw Exception(error);
        }finally{
          _refreshPage();
        }
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        margin:  const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nome da criança: ', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 5,),
                  Text(children.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Risco', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                  Text(children.risk == ''? '---': children.risk.split(' ')[1], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: getColor(children.risk)), textAlign: TextAlign.center,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColor(String risk){
    if(risk == 'Risco Baixo'){
      return const Color(0xFF047E02);
    } else
    if(risk == 'Risco Médio'){
      return const Color(0xFF9D9702);
    }else{
      return const Color(0xFFFF0000);
    }
  }
}

