import 'dart:convert';

import 'package:cash_whiz/core/models/list_product_model.dart';
import 'package:http/http.dart';

class ListProductRepository {
  String userUrl = 'http://192.168.1.6:80/api/list_product';

  Future<List<ListProductModel>> getListProduct() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => ListProductModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
