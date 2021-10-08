// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class NewsDataController extends GetxController {
  List data = [].obs;

  RxBool loading = false.obs;

  NewsDataController() {
    loadData();
  }

  loadData() async {
    loading(true);

    var url =
        "https://newsapi.org/v2/top-headlines?country=jp&apiKey=a7671b32f93f4086901844f9d805d0bc";

    var response = await http.get(Uri.parse(url));

    var decoded = json.decode(response.body);
    data = decoded['articles'];

    loading(false);
  }
}

class NewsDataDisplayScreen extends StatelessWidget {
  final NewsDataController newsDataController = Get.put(NewsDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (newsDataController.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: newsDataController.data.length,
            itemBuilder: (context, index) => Card(
              color: Colors.grey.withOpacity(0.1),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  newsDataController.data[index]['title'],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
