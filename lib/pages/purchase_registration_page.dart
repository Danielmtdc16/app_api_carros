import 'package:flutter/material.dart';
import 'package:app_api_carros/widgets/text_field.dart';
import 'package:app_api_carros/models/Car.dart';
import 'package:app_api_carros/database/db.dart';


class PurchaseRegistrationPage extends StatefulWidget {

  Car? car;

  PurchaseRegistrationPage({Key? key, this.car}) : super(key: key);

  @override
  State<PurchaseRegistrationPage> createState() => _PurchaseRegistrationPageState();
}

class _PurchaseRegistrationPageState extends State<PurchaseRegistrationPage> {

  String _textAviso = 'Compra concluída com Sucesso!';

  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();

  _savePurchase() async {
    String nomeUser = _nomeController.text;
    String cpfUser = _cpfController.text;

    if (nomeUser.isNotEmpty && cpfUser.isNotEmpty) {
      int resultado = await DB.instance.insertPurchase(nomeUser, cpfUser, widget.car!);
      if (resultado == 0) {
        setState(() {
          _textAviso = 'Erro ao processa compra!';
        });
      }
    } else {
      setState(() {
        _textAviso = 'Erro ao processa compra!';
      });
    }
  }

  void _exibirMensagemPosOperacao(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Situação da Compra'),
            content: Text(_textAviso),
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

  Future<void> _preencherCampos() async {

    Map<String, dynamic>? user = await DB.instance.getAllUsers();

    if (user != null) {
      setState(() {
        _nomeController.text = user['nomeUser'];
        _cpfController.text = user['cpfUser'];
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _preencherCampos();
  }

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
                    controller: _nomeController,
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
                      _exibirMensagemPosOperacao(context);
                    },
                    child: Container(
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
