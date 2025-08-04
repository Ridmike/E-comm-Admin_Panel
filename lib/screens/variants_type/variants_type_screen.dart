import 'package:admin_panel/screens/variants_type/component/add_varaint_type_form.dart';
import 'package:admin_panel/screens/variants_type/component/variant_type_header.dart';
import 'package:admin_panel/screens/variants_type/component/variant_type_list_section.dart';
import 'package:admin_panel/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import 'package:provider/provider.dart';
import '../../core/data/data_provider.dart';
import './provider/variants_type_provider.dart';

class VariantsTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            VariantsTypeHeader(),
            Gap(defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "My Variant Types",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              showAddVariantsTypeForm(context, null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                          Gap(20),
                          IconButton(
                            onPressed: () {
                              context.dataProvider.getAllVariantTypes(
                                showSnack: true,
                              );
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      Gap(defaultPadding),
                      ChangeNotifierProvider(
                        create: (_) => VariantsTypeProvider(
                          Provider.of<DataProvider>(context, listen: false),
                        ),
                        child: VariantsTypeListSection(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
