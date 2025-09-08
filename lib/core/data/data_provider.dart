import 'package:admin_panel/models/api_response.dart';
import 'package:admin_panel/models/brand.dart';
import 'package:admin_panel/models/category.dart';
import 'package:admin_panel/models/coupon.dart';
import 'package:admin_panel/models/my_notification.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/poster.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/sub_category.dart';
import 'package:admin_panel/models/variant.dart';
import 'package:admin_panel/models/variant_type.dart';
import 'package:admin_panel/services/http_service.dart';
import 'package:admin_panel/utility/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get_connect/http/src/response/response.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];
  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {
    getAllProduct();
    getAllCategory();
    getAllSubCategories();
    getAllBrand();
    getAllVariantTypes();
    getAllVariants();
    getAllPosters();
    getAllCoupons();
    getAllOrders();
  }

  // Get All Categories
  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "categories");
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
              response.body,
              (json) => (json as List)
                  .map((item) => Category.fromJson(item))
                  .toList(),
            );
        _allCategories = apiResponse.data ?? [];
        _filteredCategories = List.from(_allCategories);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCategories;
  }

  // Filter Categories
  void filterCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Sub Categories
  Future<List<SubCategory>> getAllSubCategories({
    bool showSnack = false,
  }) async {
    try {
      Response response = await service.getItems(endpointUrl: "subCategories");
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(
              response.body,
              (json) => (json as List)
                  .map((item) => SubCategory.fromJson(item))
                  .toList(),
            );
        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories = List.from(_allSubCategories);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSubCategories;
  }

  // Filter Sub Categories
  void filterSubCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subCategory) {
        return (subCategory.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Brands
  Future<List<Brand>> getAllBrand({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "brands");
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(
              response.body,
              (json) =>
                  (json as List).map((item) => Brand.fromJson(item)).toList(),
            );
        _allBrands = apiResponse.data ?? [];
        _filteredBrands = List.from(_allBrands);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredBrands;
  }

  // Filter All Brands
  void filterBrands(String keyword) {
    if (keyword.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Vatiant Types
  Future<List<VariantType>> getAllVariantTypes({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "variantTypes");
      if (response.isOk) {
        ApiResponse<List<VariantType>> apiResponse = ApiResponse.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => VariantType.fromJson(item)).toList(),
        );
        _allVariantTypes = apiResponse.data ?? [];
        _filteredVariantTypes = List.from(_allVariantTypes);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        return _filteredVariantTypes;
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredVariantTypes;
  }

  // Filter Variant Types
  void filterVariantTypes(String keyword) {
    if (keyword.isEmpty) {
      _filteredVariantTypes = List.from(_allVariantTypes);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredVariantTypes = _allVariantTypes.where((variantTypes) {
        return (variantTypes.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Variants
  Future<List<Variant>> getAllVariants({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'variants');
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            ApiResponse<List<Variant>>.fromJson(
              response.body,
              (json) =>
                  (json as List).map((item) => Variant.fromJson(item)).toList(),
            );
        _allVariants = apiResponse.data ?? [];
        _filteredVariants = List.from(_allVariants);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredVariants;
  }

  // Filter All Variants
  void filterVariants(String keyword) {
    if (keyword.isEmpty) {
      _filteredVariants = List.from(_allVariants);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredVariants = _allVariants.where((variant) {
        return (variant.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Products
  Future<List<Product>> getAllProduct({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');
      if (response.isOk) {
        ApiResponse<List<Product>> apiResponse =
            ApiResponse<List<Product>>.fromJson(
              response.body,
              (json) =>
                  (json as List).map((item) => Product.fromJson(item)).toList(),
            );
        _allProducts = apiResponse.data ?? [];
        _filteredProducts = List.from(_allProducts);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      } else {
        if (showSnack)
          SnackBarHelper.showErrorSnackBar('Failed to fetch products');
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredProducts;
  }

  // Filter Products
  void filterProducts(String keyword) {
    if (keyword.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredProducts = _allProducts.where((product) {
        final productNameContainsKeyword = (product.name ?? '')
            .toLowerCase()
            .contains(lowerKeyword);
        final categoryNameContainsKeyword =
            product.proSubCategoryId?.name?.toLowerCase().contains(
              lowerKeyword,
            ) ??
            false;
        final subCategoryNameContainsKeyword =
            product.proSubCategoryId?.name?.toLowerCase().contains(
              lowerKeyword,
            ) ??
            false;

        return productNameContainsKeyword ||
            categoryNameContainsKeyword ||
            subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  // Get All Posters
  Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'posters');
      if (response.isOk) {
        ApiResponse<List<Poster>> apiResponse =
            ApiResponse<List<Poster>>.fromJson(
              response.body,
              (json) =>
                  (json as List).map((item) => Poster.fromJson(item)).toList(),
            );
        _allPosters = apiResponse.data ?? [];
        _filteredPosters = List.from(_allPosters);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredPosters;
  }

  // Filter Posters
  void filterPosters(String keyword) {
    if (keyword.isEmpty) {
      _filteredPosters = List.from(_allPosters);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredPosters = _allPosters.where((poster) {
        return (poster.posterName ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Coupons
  Future<List<Coupon>> getAllCoupons({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'couponCodes');
      if (response.isOk) {
        ApiResponse<List<Coupon>> apiResponse =
            ApiResponse<List<Coupon>>.fromJson(
              response.body,
              (json) =>
                  (json as List).map((item) => Coupon.fromJson(item)).toList(),
            );
        _allCoupons = apiResponse.data ?? [];
        _filteredCoupons = List.from(_allCoupons);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCoupons;
  }

  // Filter Coupons
  void filterCoupons(String keyword) {
    if (keyword.isEmpty) {
      _filteredCoupons = List.from(_allCoupons);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredCoupons = _allCoupons.where((coupon) {
        return (coupon.couponCode ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  // Get All Orders
  Future<List<Order>> getAllOrders({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'orders');
      if (response.isOk) {
        ApiResponse<List<Order>> apiResponse =
            ApiResponse<List<Order>>.fromJson(
              response.body,
              (json) =>
                  (json as List).map((item) => Order.fromJson(item)).toList(),
            );
        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredOrders;
  }

  // Filter Orders
  void filterOrders(String keyword) {
    if (keyword.isEmpty) {
      _filteredOrders = List.from(_allOrders);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredOrders = _allOrders.where((order) {
        bool nameMatch = (order.userID?.name ?? '').toLowerCase().contains(
          lowerKeyword,
        );
        bool statusMatch = (order.orderStatus ?? '').toLowerCase().contains(
          lowerKeyword,
        );
        return nameMatch || statusMatch;
      }).toList();
    }
    notifyListeners();
  }

  // Calculate Order With Status
  int calculateOrderWithStatus({String? status}) {
    int totalOrders = 0;
    if (status == null) {
      totalOrders = _allOrders.length;
    } else {
      for (Order order in _allOrders) {
        if (order.orderStatus == status) {
          totalOrders += 1;
        }
      }
    }
    return totalOrders;
  }

  // Filter Product By the Quantity
  void filterProductsByQuantity(String productQntType) {
    if (productQntType == 'All Products') {
      _filteredProducts = List.from(_allProducts);
    } else if (productQntType == 'Out of Stock') {
      _filteredProducts = _allProducts.where((product) {
        // Filerting products that are out of stock
        return product.quantity != null && product.quantity == 0;
      }).toList();
    } else if (productQntType == 'Limited Stock') {
      _filteredProducts = _allProducts.where((product) {
        // Filtering products that are in limited stock
        return product.quantity != null && product.quantity == 1;
      }).toList();
    } else if (productQntType == 'Other Stock') {
      _filteredProducts = _allProducts.where((product) {
        // Filtering products that are in other stock
        return product.quantity != null &&
            product.quantity != 0 &&
            product.quantity != 1;
      }).toList();
    } else {
      _filteredProducts = List.from(_allProducts);
    }
    notifyListeners();
  }

  // Products No of Quantity
  int calculateProductWithQuantity({int? quantity}) {
    int totalProducts = 0;

    if (quantity == null) {
      totalProducts = _filteredProducts.length;
    } else {
      for (Product product in _allProducts) {
        if (product.quantity != null && product.quantity == quantity) {
          totalProducts++;
        }
      }
    }
    return totalProducts;
  }
}
