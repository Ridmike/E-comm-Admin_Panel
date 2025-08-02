import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/models/category.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get_connect/http/src/response/response.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  DataProvider() {}

  // Get All Categories
  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "categories");
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
              response.body,
              (json) => (json as List)
                  .map((item) => Category.fromJson(item))
                  .toList(),
            );
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCategories;
  }

  // Filter Categories
  void filterCategories(String keyword) {
  if (keyword.isEmpty) {
    _filteredCategories = List.from(_allCategories);
  } else {
    final lowerKeyword = keyword.toLowerCase();
    _filteredCategories = _allCategories.where((category) {
      return (category.name ?? '').toLowerCase().contains(lowerKeyword);
    }).toList();
  }
  notifyListeners();
  }
}

