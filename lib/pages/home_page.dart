import 'package:app_api_carros/pages/purchase_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:app_api_carros/util/ConsultaAPI.dart';
import 'package:app_api_carros/models/Car.dart';

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
    ConsultaApi.request().then((value) {
      setState(() {
        _cars = value.map((car) => Car.fromJson(car)).toList();
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B455E),
        shadowColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 25,
        ),
        title: Text('Carros API'),
        toolbarHeight: 100,
        leading: Icon(Icons.menu_outlined, size: 25,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(Icons.account_circle_outlined, size: 40,),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2D3447),
              Color(0xFF252B3B),
              Color(0xFF151821)
            ]
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                      decoration: InputDecoration(
                          hintText: 'Pesquisar',
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide(
                              color: Colors.white
                          ),),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white
                          ),),
                          fillColor: Colors.transparent,
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: Icon(Icons.search_outlined),
                        suffixIconColor: Colors.white
                      ),

                    ),
                  ),

                  SizedBox(width: 15,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'Filtrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20,),

              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF32C8FB),
                            Color(0xFF1C6DE3),
                            Color(0xFF1141C1)
                          ]
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.car_rental_outlined, size: 50, color: Colors.white,),
                            SizedBox(height: 10,),
                            Text('${_cars[index].nomeModelo}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text('R\$ ${_cars[index].valor.toStringAsFixed(3)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${_cars[index].ano}', style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),),
                                Text('${_cars[index].combustivel}', style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),),
                                Text('${_cars[index].cor}', style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      width: 200,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFFF9470),
                                                Color(0xFFF23E6B),
                                                Color(0xFFAA235E)
                                              ]
                                          )
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Favoritar',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      openPurchaseRegistrationScreen(context, _cars[index]);
                                    },
                                    child: Container(
                                      width: 200,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFF2D3447),
                                                Color(0xFF252B3B),
                                                Color(0xFF151821)
                                              ]
                                          )
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Eu quero',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _cars.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


