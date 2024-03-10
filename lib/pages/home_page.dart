import 'package:app_api_carros/pages/purchase_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:app_api_carros/util/ConsultaAPI.dart';
import 'package:app_api_carros/models/Car.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Car> _cars = [];

  openPurchaseRegistrationScreen(BuildContext context, Car car) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PurchaseRegistrationPage(car: car,)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConsultaApi.request().then((value) {
      setState(() {
        _cars = value.map((car) => Car.fromJson(car)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Carros'),
        centerTitle: true,

      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text("${_cars[index].nomeModelo}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Valor: R\$ ${_cars[index].valor}"),
                      Text("Ano: ${_cars[index].ano}"),
                      Text("Combustível: ${_cars[index].combustivel}"),
                      Text("Núm. Portas: ${_cars[index].numPortas}"),
                      Text("Cor: ${_cars[index].cor}"),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          openPurchaseRegistrationScreen(context, _cars[index]);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Eu quero", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  leading: Text("1"),
                  isThreeLine: true,
                ),
              ),
            );
          },
          itemCount: _cars.length,
        ),
      ),
    );
  }


}


