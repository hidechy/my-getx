// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class GoldDataController extends GetxController {
  List data = [].obs;

  RxBool loading = false.obs;

  GoldDataController() {
    loadData();
  }

  loadData() async {
    loading(true);

    var url = "http://toyohide.work/BrainLog/api/getgolddata";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    var decoded = json.decode(response.body);
    data = decoded['data'];

    loading(false);
  }
}

class GoldDataDisplayScreen extends StatelessWidget {
  final GoldDataController goldDataController = Get.put(GoldDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (goldDataController.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: goldDataController.data.length,
            itemBuilder: (context, index) {
              var date =
                  "${goldDataController.data[index]['year']}-${goldDataController.data[index]['month']}-${goldDataController.data[index]['day']}";

              return Card(
                color: Colors.grey.withOpacity(0.1),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(date),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
