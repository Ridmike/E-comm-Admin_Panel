import 'package:admin_panel/screens/main/provider/main_screen_provider.dart';
import 'package:admin_panel/screens/sub_categosy/provider/sub_category_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/data/data_provider.dart';
import '../screens/category/provider/category_provider.dart';


extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  MainScreenProvider get mainScreenProvider => Provider.of<MainScreenProvider>(this, listen: false);
  CategoryProvider get categoryProvider => Provider.of<CategoryProvider>(this, listen: false);
  SubCategoryProvider get subCategoryProvider => Provider.of<SubCategoryProvider>(this, listen: false);
  
}