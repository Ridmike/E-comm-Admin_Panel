import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';

class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;

  SubCategoryProvider(this._dataProvider);

  // Add Sub Category
  addSubCategory() async {
    try {
      Map<String, dynamic> subCategory = {
        'name': subCategoryNameCtrl.text,
        'categoryId': selectedCategory?.sId,
      };
      final response = await service.addItem(
        endpointUrl: "subcategories",
        itemData: subCategory,
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
          _dataProvider.getAllSubCategories();
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Faild to added SubCategory: ${apiResponse.message}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error: ${response.body?['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
    }
  }

  // Update Sub Category
  updateSubCategory() async {
    try {
      if (subCategoryForUpdate != null) {
        Map<String, dynamic> subCategory = {
          'name': subCategoryNameCtrl.text,
          'categoryId': selectedCategory?.sId,
        };
        final response = await service.updateItem(
          endpointUrl: "subcategories",
          itemId: subCategoryForUpdate!.sId ?? '',
          itemData: subCategory,
        );
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(' ${apiResponse.message}');
            _dataProvider.getAllSubCategories();
          } else {
            SnackBarHelper.showErrorSnackBar(
              'Failed to update SubCategory: ${apiResponse.message}',
            );
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? 'Unknown error'}',
          );
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Error ${subCategoryForUpdate?.name ?? ''} not found',
        );
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
    }
  }

  // Submit Button Action
  submitSubCategory() {
    if (subCategoryForUpdate != null) {
      updateSubCategory();
    } else {
      addSubCategory();
    }
  }

  // Delete SubCategory
  deleteSubCategory(SubCategory subCategory) async {
    try {
      Response response = await service.deleteItem(
        endpointUrl: 'subCategories',
        itemId: subCategory.sId ?? '',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(
            'Sub Category Delete Successfully',
          );
          _dataProvider.getAllCategory();
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

  setDataForUpdateSubCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull(
        (element) => element.sId == subCategory.categoryId?.sId,
      );
    } else {
      clearFields();
    }
  }

  clearFields() {
    subCategoryNameCtrl.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  updateUi() {
    notifyListeners();
  }
}
