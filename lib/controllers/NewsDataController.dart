import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsDataCoxxntroller extends GetxController {
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
