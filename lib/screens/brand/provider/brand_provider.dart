import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/utility/snack_bar.dart';
import '../../../models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_service.dart';

class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  SubCategory? selectedSubCategory;
  Brand? brandForUpdate;

  BrandProvider(this._dataProvider);

  // Add Brand
  addBrand() async {
    try {
      Map<String, dynamic> brand = {
        'name': brandNameCtrl.text,
        'subcategoryId': selectedSubCategory?.sId,
      };
      final response = await service.addItem(
        endpointUrl: 'brands',
        itemData: brand,
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
          _dataProvider.getAllBrand();
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Faild to added Brand: ${apiResponse.message}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error: ${response.body?['message'] ?? response.statusText}',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occurred: $e');
      rethrow;
    }
  }

  //UpdateBrand

  updateBrand() async {
    try {
      if (brandForUpdate != null) {
        Map<String, dynamic> brand = {
          'name': brandNameCtrl.text,
          'subcategoryId': selectedSubCategory?.sId,
        };
        final response = await service.updateItem(
          endpointUrl: "brands",
          itemId: brandForUpdate?.sId ?? '',
          itemData: brand,
        );
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
            _dataProvider.getAllBrand();
          } else {
            SnackBarHelper.showErrorSnackBar(
              'Failed to update Brand: ${apiResponse.message}',
            );
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}',
          );
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  // Submit Button Action
  submitBrand() {
    if (brandForUpdate != null) {
      updateBrand();
    } else {
      addBrand();
    }
  }

  // Delete SubCategory
  deleteBrand(Brand brand) async {
    try {
      Response response = await service.deleteItem(
        endpointUrl: 'brands',
        itemId: brand.sId ?? '',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Brand Delete Successfully');
          _dataProvider.getAllBrand();
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

  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull(
        (element) => element.sId == brand.subcategoryId?.sId,
      );
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  updateUI() {
    notifyListeners();
  }
}
