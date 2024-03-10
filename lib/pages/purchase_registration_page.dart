import 'package:flutter/material.dart';
import 'package:app_api_carros/widgets/text_field.dart';
import 'package:app_api_carros/models/Car.dart';
import 'package:app_api_carros/pages/purchase_registration_page.dart';

class PurchaseRegistrationPage extends StatefulWidget {

  Car? car;

  PurchaseRegistrationPage({Key? key, this.car}) : super(key: key);

  @override
  State<PurchaseRegistrationPage> createState() => _PurchaseRegistrationPageState();
}

class _PurchaseRegistrationPageState extends State<PurchaseRegistrationPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Compra'),
        titleTextStyle: TextStyle(
          color: Colors.black45,
          fontSize: 18
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_return_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20,),
                  Text(
                    'Preencha os campos \ncom seus dados',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 40,),
                  MeuTextField(
                  hintTextInput: "Nome completo",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20,),
                  MeuTextField(
                      hintTextInput: "CPF",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Center(
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
