import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
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
          // _dataProvider
        }
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An Error Occurred: $e');
      rethrow;
    }
  }
  //TODO: should complete addVariantType

  //TODO: should complete updateVariantType

  //TODO: should complete submitVariantType

  //TODO: should complete deleteVariantType

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
