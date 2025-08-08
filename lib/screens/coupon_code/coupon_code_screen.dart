import 'package:admin_panel/screens/coupon_code/components/coupon_list_section.dart';
import 'package:admin_panel/utility/extensions.dart';
import 'components/coupon_code_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../utility/constants.dart';
import 'components/add_coupon_form.dart';
import 'provider/coupon_code_provider.dart';

class CouponCodeScreen extends StatelessWidget {
  const CouponCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CouponCodeProvider(context.dataProvider),
      child: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            primary: false,
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const CouponCodeHeader(),
                const Gap(defaultPadding),
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
                                  "My Coupons",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                                  showAddCouponForm(context, null);
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Add New"),
                              ),
                              const Gap(20),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<CouponCodeProvider>()
                                      .getAllCoupons(showSnack: true);
                                },
                                icon: const Icon(Icons.refresh),
                              ),
                            ],
                          ),
                          const Gap(defaultPadding),
                          const CouponListSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
