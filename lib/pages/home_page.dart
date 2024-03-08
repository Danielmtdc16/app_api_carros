import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Carros'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nome do Modelo: Onix Plus'),
                            SizedBox(height: 10,),
                            Text('ano: 2015'),
                            SizedBox(height: 10,),
                            Text('Combustivel: Flex'),
                            SizedBox(height: 10,),
                            Text('Núm. Portas: 4'),
                            SizedBox(height: 10,),
                            Text('Cor: Bege'),
                            SizedBox(height: 10,),
                            Text('Valor: RS 50.000'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text('Eu quero'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome do Modelo: Onix Plus'),
                    SizedBox(height: 10,),
                    Text('ano: 2015'),
                    SizedBox(height: 10,),
                    Text('Combustivel: Flex'),
                    SizedBox(height: 10,),
                    Text('Núm. Portas: 4'),
                    SizedBox(height: 10,),
                    Text('Cor: Bege'),
                    SizedBox(height: 10,),
                    Text('Valor: RS 50.000'),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome do Modelo: Onix Plus'),
                    SizedBox(height: 10,),
                    Text('ano: 2015'),
                    SizedBox(height: 10,),
                    Text('Combustivel: Flex'),
                    SizedBox(height: 10,),
                    Text('Núm. Portas: 4'),
                    SizedBox(height: 10,),
                    Text('Cor: Bege'),
                    SizedBox(height: 10,),
                    Text('Valor: RS 50.000'),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}


