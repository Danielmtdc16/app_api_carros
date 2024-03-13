import 'package:flutter/material.dart';
import 'package:app_api_carros/pages/home_page.dart';
import 'package:app_api_carros/util/ConsultaAPI.dart';
import 'package:app_api_carros/database/db.dart';
import 'package:cron/cron.dart';
import 'package:sqflite/sqflite.dart';


Future<void> main() async {

  final cron = Cron();

  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    await ConsultaApi.requestLeads();
    await ConsultaApi.sendData();
  });

  runApp(MaterialApp(
    home: HomePage(),
  ));
}


