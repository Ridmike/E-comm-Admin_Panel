import 'package:admin_panel/models/category.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  DataProvider() {}
}
