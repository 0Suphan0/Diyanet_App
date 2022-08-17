final String tableProduct = 'products';

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    productId,
    productName,
    productOperationMethod,
    productMaintainer,
    productMaintainerInstitution,
    productDoneTimes,
    productMaintainerNote,
    productMaintenanceType
  ];

  static final String productId = "_id";
  static final String productName = "productName";
  static final String productOperationMethod = "productOperationMethod";
  static final String productMaintainer = "productMaintainer";
  static final String productMaintainerInstitution =
      "productMaintainerInstitution";
  static final String productDoneTimes = "productDoneTimes";
  static final String productMaintainerNote = "productMaintainerNote";
  static final String productMaintenanceType = "productMaintenanceType";
}

class Product {
  int? productId;
  String? productName;
  String? productOperationMethod;
  String? productMaintainer;
  String? productMaintainerInstitution;
  String? productDoneTimes;
  String? productMaintainerNote;
  String? productMaintenanceType;

  Product({
    this.productId,
   required this.productName,
   required this.productOperationMethod,
   required this.productMaintainer,
   required this.productMaintainerInstitution,
   required this.productDoneTimes,
   required this.productMaintainerNote,
   required this.productMaintenanceType,
  });

   Product copy({
  int? productId,
  String? productName,
  String? productOperationMethod,
  String? productMaintainer,
  String? productMaintainerInstitution,
  String? productDoneTimes,
  String? productMaintainerNote,
  String? productMaintenanceType,
  }) =>
      Product(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productOperationMethod: productOperationMethod ?? this.productOperationMethod,
        productMaintainer: productMaintainer ?? this.productMaintainer,
        productMaintainerInstitution: productMaintainerInstitution ?? this.productMaintainerInstitution,
        productDoneTimes: productDoneTimes ?? this.productDoneTimes,
        productMaintainerNote: productMaintainerNote ?? this.productMaintainerNote,
        productMaintenanceType: productMaintenanceType ?? this.productMaintenanceType,

      );
  

  Map<String, Object?> toJson() => {
        ProductFields.productId: productId,
        ProductFields.productName: productName,
        ProductFields.productOperationMethod: productOperationMethod,
        ProductFields.productMaintainer: productMaintainer,
        ProductFields.productMaintainerInstitution: productMaintainerInstitution,
        ProductFields.productDoneTimes: productDoneTimes,
        ProductFields.productMaintainerNote: productMaintainerNote,
        ProductFields.productMaintenanceType: productMaintenanceType,
      };

  static Product fromJson(Map<String, Object?> json) => Product(
        productId: json[ProductFields.productId] as int?,
        productName: json[ProductFields.productName] as String,
        productOperationMethod: json[ProductFields.productOperationMethod] as String,
        productMaintainer: json[ProductFields.productMaintainer] as String,
        productMaintainerInstitution: json[ProductFields.productMaintainerInstitution] as String,
        productDoneTimes: json[ProductFields.productDoneTimes] as String,
        productMaintainerNote: json[ProductFields.productMaintainerNote] as String,
        productMaintenanceType: json[ProductFields.productMaintenanceType] as String,
      );
}
