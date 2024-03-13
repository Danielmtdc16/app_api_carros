import 'package:flutter/material.dart';
import 'package:app_api_carros/widgets/text_field.dart';
import 'package:app_api_carros/models/Car.dart';
import 'package:app_api_carros/database/db.dart';


class PurchaseRegistrationPage extends StatefulWidget {

  final Car? car;

  const PurchaseRegistrationPage({Key? key, this.car}) : super(key: key);

  @override
  State<PurchaseRegistrationPage> createState() => _PurchaseRegistrationPageState();
}

class _PurchaseRegistrationPageState extends State<PurchaseRegistrationPage> {

  // variavel para alertar user da situacao da compra
  String _warningText = 'Compra concluída com Sucesso!';

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();

  // funcao para salvar os dados da compra e do usuario no banco de dados
  _savePurchase() async {
    String nomeUser = _nameController.text;
    String cpfUser = _cpfController.text;

    if (nomeUser.isNotEmpty && cpfUser.isNotEmpty) {
      int resultado = await DB.instance.insertPurchase(nomeUser, cpfUser, widget.car!);
      if (resultado == 0) {
        setState(() {
          _warningText = 'Erro ao processa compra!';
        });
      }
    } else {
      setState(() {
        _warningText = 'Erro ao processa compra!';
      });
    }
  }

  // funcao para chamar uma caixa de dialogo para alertar o usuario sobre a compra
  void _displayPostOperationMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Situação da Compra'),
            content: Text(_warningText),
            actions: <Widget>[
              TextButton(onPressed: () {
                Navigator.of(context).pop();
                Navigator.popUntil(context, (route) => route.isFirst);
              }, child: Text('Fechar'))
            ],
          );
        }
    );
  }

  // funcao para preencher os dados do user se já existir um user no banco
  Future<void> _fillInFields() async {

    Map<String, dynamic>? user = await DB.instance.getAllUsers();

    if (user != null) {
      setState(() {
        _nameController.text = user['nomeUser'];
        _cpfController.text = user['cpfUser'];
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fillInFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Compra'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Color(0xFF3B455E),
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
                    'Item para compra',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(right: 15, left: 15, top: 30, bottom: 30),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Icon(
                                Icons.directions_car,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('${widget.car!.nomeModelo}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text('${widget.car!.numPortas} PORTAS',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),),
                                Text('${widget.car!.combustivel}',
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                                Text('${widget.car!.ano}',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),),
                                Text('${widget.car!.cor}',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),),
                                Text('R\$ ${widget.car!.valor.toStringAsFixed(3)}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Preencha os campos',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 15,),
                  MeuTextField(
                    controller: _nameController,
                    hintTextInput: "Nome completo",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                  ),
                  SizedBox(height: 20,),
                  MeuTextField(
                    controller: _cpfController,
                      hintTextInput: "CPF",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      )
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      _savePurchase();
                      _displayPostOperationMessage(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)
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
