import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainScreenProvider extends ChangeNotifier{
  Widget selectedScreen = Placeholder(); // Default screen, can be replaced with an actual screen widget



  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        break; 
      case 'Category':
        break;
      case 'SubCategory':
        break;
      case 'Brands':
        break;
      case 'VariantType':
        break;
      case 'Variants':
        break;
      case 'Coupon':
        break;
      case 'Poster':
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