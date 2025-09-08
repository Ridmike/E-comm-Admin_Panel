import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snackbar_helper.dart';
import 'package:get/get.dart';
import '../../../models/order.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';

class OrderProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final orderFormKey = GlobalKey<FormState>();
  TextEditingController trackingUrlCtrl = TextEditingController();
  String selectedOrderStatus = 'pending';
  Order? orderForUpdate;

  OrderProvider(this._dataProvider);

  //  UpdateOrder
  updateOrder() async {
    try {
      if (orderForUpdate != null) {
        Map<String, dynamic> order = {
          'trackingUrl': trackingUrlCtrl.text,
          'orderStatus': selectedOrderStatus,
        };
        final response = await service.updateItem(
          endpointUrl: 'orders',
          itemId: orderForUpdate?.sId ?? '',
          itemData: order,
        );
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            _dataProvider.getAllOrders();
          } else {
            SnackBarHelper.showErrorSnackBar(
              'Failed to update order: ${apiResponse.message}',
            );
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusCode}',
          );
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Exception: $e');
      rethrow;
    }
  }

  //  Delete Order
  deleteOrder(Order order) async {
    try {
      Response response = await service.deleteItem(
        endpointUrl: 'orders',
        itemId: order.sId ?? '',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Order deleted successfully');
          _dataProvider.getAllOrders();
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Failed to delete order: ${apiResponse.message}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error: ${response.body?['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Exception: $e');
      rethrow;
    }
  }

  updateUI() {
    notifyListeners();
  }
}
