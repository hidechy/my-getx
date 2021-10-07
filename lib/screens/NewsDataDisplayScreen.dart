import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/NewsDataController.dart';

class NewsDataDisplayScreen extends StatelessWidget {
  final NewsDataController newsDataController = Get.put(NewsDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(
          () {
            if (newsDataController.loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: newsDataController.data.length,
              itemBuilder: (context, index) => Card(
                color: Colors.grey.withOpacity(0.1),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    newsDataController.data[index]['title'],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
