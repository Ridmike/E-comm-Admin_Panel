import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainScreenProvider extends ChangeNotifier{
  Widget selectedScreen = Placeholder(); // Default screen, can be replaced with an actual screen widget



  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        // selectedScreen = DashboardScreen();
        break; // Break statement needed here
      case 'Category':
        // selectedScreen = CategoryScreen();
        break;
      case 'SubCategory':
        // selectedScreen = SubCategoryScreen();
        break;
      case 'Brands':
        // selectedScreen = BrandScreen();
        break;
      case 'VariantType':
        // selectedScreen = VariantsTypeScreen();
        break;
      case 'Variants':
        // selectedScreen = VariantsScreen();
        break;
      case 'Coupon':
        // selectedScreen = CouponCodeScreen();
        break;
      case 'Poster':
        // selectedScreen = PosterScreen();
        break;
      case 'Order':
        // selectedScreen = OrderScreen();
        break;
      case 'Notifications':
        // selectedScreen = NotificationScreen();
        break;
      default:
        // selectedScreen = DashboardScreen();
    }
    notifyListeners();
  }
  
  
}