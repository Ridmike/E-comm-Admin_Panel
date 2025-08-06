import 'package:admin_panel/core/data/data_provider.dart';
import 'package:admin_panel/models/sub_category.dart';
import 'package:admin_panel/screens/sub_categosy/components/sub_category_form.dart';
import 'package:admin_panel/screens/sub_categosy/provider/sub_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAddSubCategoryForm(BuildContext context, SubCategory? subCategory) {
  final dataProvider = Provider.of<DataProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) => ChangeNotifierProvider(
      create: (context) => SubCategoryProvider(dataProvider),
      child: Dialog(child: SubCategorySubmitForm(subCategory: subCategory)),
    ),
  );
}
