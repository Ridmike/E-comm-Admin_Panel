import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/variant_type.dart';

class VariantsTypeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addVariantsTypeFormKey = GlobalKey<FormState>();
  TextEditingController variantNameCtrl = TextEditingController();
  TextEditingController variantTypeCtrl = TextEditingController();

  VariantType? variantTypeForUpdate;

  VariantsTypeProvider(this._dataProvider);

  addVariantType() async {
    try {
      Map<String, dynamic> variantType = {
        'name': variantNameCtrl.text,
        'type': variantTypeCtrl.text,
      };
      final response = await service.addItem(
        endpointUrl: 'variantTypes',
        itemData: variantType,
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
          _dataProvider.getAllVariantTypes();
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Failed to add Variant Type: ${apiResponse.message}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error ${response.body?['message'] ?? response.statusText}',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occurred: $e');
      rethrow;
    }
  }

  // Update Variant Types
  updateVariantTypes() async {
    try {
      if (variantTypeForUpdate != null) {
        Map<String, dynamic> variantType = {
          'name': variantNameCtrl.text,
          'type': variantTypeCtrl.text,
        };
        final response = await service.updateItem(
          endpointUrl: 'variantTypes',
          itemData: variantType,
          itemId: variantTypeForUpdate?.sId ?? '',
        );
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
            _dataProvider.getAllVariantTypes();
          } else {
            SnackBarHelper.showErrorSnackBar(
              'Failed to Add Varient Types: ${apiResponse.message}',
            );
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}',
          );
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occurred: $e');
      rethrow;
    }
  }

  // Submit Variant Type
  submitVariantType() {
    if (variantTypeForUpdate != null) {
      updateVariantTypes();
    } else {
      addVariantType();
    }
  }

  // Delete Variant Types
  deleteVariantTypes(VariantType variantType) async {
    try {
      Response response = await service.deleteItem(
        endpointUrl: 'variantType',
        itemId: variantType.sId ?? '',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(
            'Variant Type Delete Successfully',
          );
          _dataProvider.getAllVariantTypes();
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error ${response.body?['message'] ?? response.statusText}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  setDataForUpdateVariantTYpe(VariantType? variantType) {
    if (variantType != null) {
      variantTypeForUpdate = variantType;
      variantNameCtrl.text = variantType.name ?? '';
      variantTypeCtrl.text = variantType.type ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantNameCtrl.clear();
    variantTypeCtrl.clear();
    variantTypeForUpdate = null;
  }
}
