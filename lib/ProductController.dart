import 'dart:convert';

import 'package:assignment_3/utils/urls.dart';
import 'package:http/http.dart' as http;

class ProductController{
  List products = [];
  Future<void>fetchProducts() async{
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      products = data['data'];
    }

  }


  Future<void>createProducts(String name,String img, int qty, int unitPrice, int totalPrice) async{
    final response = await http.post(Uri.parse(Urls.createProduct),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().millisecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": unitPrice,
          "TotalPrice": totalPrice

        })
    );

    if (response.statusCode == 201){
      fetchProducts();

    }

  }


}