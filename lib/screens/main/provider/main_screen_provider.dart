import 'package:admin_panel/screens/brand/brand_screen.dart';
import 'package:admin_panel/screens/category/category_screen.dart';
import 'package:admin_panel/screens/dashboard/dashboard_screen.dart';
import 'package:admin_panel/screens/poster/poster_screen.dart';
import 'package:admin_panel/screens/sub_categosy/sub_category_screen.dart';
import 'package:admin_panel/screens/variants/variants_screen.dart';
import 'package:admin_panel/screens/variants_type/variants_type_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreenProvider extends ChangeNotifier {
  Widget selectedScreen = DashboardScreen();

  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        selectedScreen = DashboardScreen();
        break;
      case 'Category':
        selectedScreen = CategoryScreen();
        break;
      case 'SubCategory':
        selectedScreen = SubCategoryScreen();
        break;
      case 'Brands':
        selectedScreen = BrandScreen();
        break;
      case 'VariantType':
        selectedScreen = VariantsTypeScreen();
        break;
      case 'Variants':
        selectedScreen = VariantsScreen();
        break;
      case 'Coupon':
        break;
      case 'Poster':
        selectedScreen = PosterScreen();
        break;
      case 'Order':
        break;
      case 'Notifications':
        break;
      default:
    }
    notifyListeners();
  }
}
