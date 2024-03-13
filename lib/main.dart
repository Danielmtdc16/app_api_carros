import 'package:flutter/material.dart';
import 'package:app_api_carros/pages/home_page.dart';
import 'package:app_api_carros/util/ConsultaAPI.dart';
import 'package:cron/cron.dart';


Future<void> main() async {
  // instanciando variavel cron para usar as funcoes de agendamento de tarefas
  final cron = Cron();

  // funcao para chamar uma funcao (enviar dados para a API)
  // periodicamente com base na funcao do cron.
  // estamos enviando os dados de 1 em 1 minuto
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    await ConsultaApi.sendData();
  });

  runApp(MaterialApp(
    home: HomePage(),
  ));
}


