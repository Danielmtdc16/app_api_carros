import 'package:flutter/material.dart';
import 'package:app_api_carros/pages/home_page.dart';
import 'package:app_api_carros/util/ConsultaAPI.dart';
import 'package:cron/cron.dart';


Future<void> main() async {

  final cron = Cron();

  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    await ConsultaApi.sendData();
  });

  runApp(MaterialApp(
    home: HomePage(),
  ));
}


