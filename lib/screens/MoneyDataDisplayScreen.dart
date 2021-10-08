// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class MoneyDataController extends GetxController {
  List data = [].obs;

  RxBool loading = false.obs;

  RxString date = "".obs;

  MoneyDataController() {
    List explodedDate = DateTime.now().toString().split(' ');
    date = RxString(explodedDate[0]);

    loadData(date.toString());
  }

  loadData(String date) async {
    loading(true);

    var url = "http://toyohide.work/BrainLog/api/moneydownload";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"date": date});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    var decoded = json.decode(response.body);

    data = decoded['data'].split('|');

    loading(false);
  }
}

class MoneyDataDisplayScreen extends StatelessWidget {
  final MoneyDataController moneyDataController =
      Get.put(MoneyDataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _showDatepicker(context: context),
              color: Colors.blueAccent,
            ),
            const Divider(color: Colors.redAccent),
            Obx(
              () {
                if (moneyDataController.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Text(moneyDataController.date.toString()),
                      Text(moneyDataController.data[0]),
                      Text(moneyDataController.data[1]),
                      Text(moneyDataController.data[2]),
                      Text(moneyDataController.data[3]),
                      Text(moneyDataController.data[4]),
                      Text(moneyDataController.data[5]),
                      Text(moneyDataController.data[6]),
                      Text(moneyDataController.data[7]),
                      Text(moneyDataController.data[8]),
                      Text(moneyDataController.data[9]),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// デートピッカー表示
  void _showDatepicker({required BuildContext context}) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 6),
      locale: const Locale('ja'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            backgroundColor: Colors.black.withOpacity(0.1),
            scaffoldBackgroundColor: Colors.black.withOpacity(0.1),
            canvasColor: Colors.black.withOpacity(0.1),
            cardColor: Colors.black.withOpacity(0.1),
//            cursorColor: Colors.white,
//            buttonColor: Colors.black.withOpacity(0.1),
            bottomAppBarColor: Colors.black.withOpacity(0.1),
            dividerColor: Colors.indigo,
            primaryColor: Colors.black.withOpacity(0.1),
//            accentColor: Colors.black.withOpacity(0.1),
            secondaryHeaderColor: Colors.black.withOpacity(0.1),
            dialogBackgroundColor: Colors.black.withOpacity(0.1),
            primaryColorDark: Colors.black.withOpacity(0.1),
//            textSelectionColor: Colors.black.withOpacity(0.1),
            highlightColor: Colors.black.withOpacity(0.1),
            selectedRowColor: Colors.black.withOpacity(0.1),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      List explodedDate = selectedDate.toString().split(' ');
      moneyDataController.date = RxString(explodedDate[0]);
      moneyDataController.loadData(moneyDataController.date.toString());
    }
  }
}
