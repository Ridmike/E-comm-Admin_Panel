import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snackbar_helper.dart';
import '../../../models/variant_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/variant.dart';

class VariantsProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addVariantsFormKey = GlobalKey<FormState>();
  TextEditingController variantCtrl = TextEditingController();
  VariantType? selectedVariantType;
  Variant? variantForUpdate;

  VariantsProvider(this._dataProvider);

  // Add Variant
  addVariant() async {
    try {
      Map<String, dynamic> variant = {
        'name': variantCtrl.text,
        'variantTypeId': selectedVariantType?.sId,
      };
      final response = await service.addItem(
        endpointUrl: 'variants',
        itemData: variant,
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
          _dataProvider.getAllVariants();
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Failed To add Variant: ${apiResponse.message}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error: ${response.body?['message'] ?? response.statusText}',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error Occurred: $e');
      rethrow;
    }
  }

  //Update Variant
  updateVariant() async {
    try {
      if (variantForUpdate != null) {
        Map<String, dynamic> variant = {
          'name': variantCtrl.text,
          'variantTypeId': selectedVariantType?.sId,
        };
        final response = await service.updateItem(
          endpointUrl: "variants",
          itemId: variantForUpdate!.sId ?? '',
          itemData: variant,
        );
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
            _dataProvider.getAllVariants();
          } else {
            SnackBarHelper.showErrorSnackBar(
              'Failed to update Variants: ${apiResponse.message}',
            );
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? 'Unknown error'}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error ${variantForUpdate?.name ?? ''} not found',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
    }
  }

  // Submit Button Action
  submitVariant() {
    // Validate required fields
    if (variantCtrl.text.trim().isEmpty) {
      SnackBarHelper.showErrorSnackBar('Variant name is required');
      return;
    }
    if (selectedVariantType == null) {
      SnackBarHelper.showErrorSnackBar('Please select a variant type');
      return;
    }

    if (variantForUpdate != null) {
      updateVariant();
    } else {
      addVariant();
    }
  }

  // Delete Variant
  deleteVariant(Variant variant) async {
    try {
      Response response = await service.deleteItem(
        endpointUrl: 'variants',
        itemId: variant.sId ?? '',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Variant Delete Successfully');
          _dataProvider.getAllVariants();
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

  setDataForUpdateVariant(Variant? variant) {
    if (variant != null) {
      variantForUpdate = variant;
      variantCtrl.text = variant.name ?? '';
      selectedVariantType = _dataProvider.variantTypes.firstWhereOrNull(
        (element) => element.sId == variant.variantTypeId?.sId,
      );
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantCtrl.clear();
    selectedVariantType = null;
    variantForUpdate = null;
  }

  void updateUI() {
    notifyListeners();
  }
}
