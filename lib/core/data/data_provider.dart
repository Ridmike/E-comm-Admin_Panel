import 'package:admin_panel/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;

class DataProvider extends ChangeNotifier {

  HttpService service = HttpService();


  DataProvider() {}

}
