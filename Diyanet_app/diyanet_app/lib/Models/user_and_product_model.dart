import 'package:diyanet_app/Models/product_model.dart';

final String tableUserAndProduct = 'usersAndProducts';

class UserAndProductField {
  static final List<String> values = [
    /// Add all fields
    tableId,
    userId,
    productId,
    productName,
    productOperationMethod,
    productMaintainer,
    productMaintainerInstitution,
    productDoneTimes,
    productMaintainerNote,
    productMaintenanceType,
    isTaskDone
  ];

  static final String tableId = "_tableId";
  static final String userId = "_userId";
  static final String productId = "_productId";
  static final String productName = "productName";
  static final String productOperationMethod = "productOperationMethod";
  static final String productMaintainer = "productMaintainer";
  static final String productMaintainerInstitution =
      "productMaintainerInstitution";
  static final String productDoneTimes = "productDoneTimes";
  static final String productMaintainerNote = "productMaintainerNote";
  static final String productMaintenanceType = "productMaintenanceType";
  static final String isTaskDone = "isTaskDone";
}

class UserAndProduct {
  int? tableId;
  int? userId;
  int? productId;
  String? productName;
  String? productOperationMethod;
  String? productMaintainer;
  String? productMaintainerInstitution;
  String? productDoneTimes;
  String? productMaintainerNote;
  String? productMaintenanceType;
  int? isTaskDone;

  UserAndProduct(
      {this.tableId,
      required this.userId, // buraya bak
      required this.productId, //buraya bak
      required this.productName,
      required this.productOperationMethod,
      required this.productMaintainer,
      required this.productMaintainerInstitution,
      required this.productDoneTimes,
      required this.productMaintainerNote,
      required this.productMaintenanceType,
      required this.isTaskDone});

  UserAndProduct copy(
          {int? tableId,
          int? userId,
          int? productId,
          String? productName,
          String? productOperationMethod,
          String? productMaintainer,
          String? productMaintainerInstitution,
          String? productDoneTimes,
          String? productMaintainerNote,
          String? productMaintenanceType,
          int? isTaskDone}) =>
      UserAndProduct(
          tableId: tableId ?? this.tableId,
          userId: userId ?? this.userId,
          productId: productId ?? this.productId,
          productName: productName ?? this.productName,
          productOperationMethod:
              productOperationMethod ?? this.productOperationMethod,
          productMaintainer: productMaintainer ?? this.productMaintainer,
          productMaintainerInstitution:
              productMaintainerInstitution ?? this.productMaintainerInstitution,
          productDoneTimes: productDoneTimes ?? this.productDoneTimes,
          productMaintainerNote:
              productMaintainerNote ?? this.productMaintainerNote,
          productMaintenanceType:
              productMaintenanceType ?? this.productMaintenanceType,
          isTaskDone: isTaskDone ?? isTaskDone);

  Map<String, Object?> toJson() => {
        UserAndProductField.tableId: tableId,
        UserAndProductField.userId: userId,
        UserAndProductField.productId: productId,
        UserAndProductField.productName: productName,
        UserAndProductField.productOperationMethod: productOperationMethod,
        UserAndProductField.productMaintainer: productMaintainer,
        UserAndProductField.productMaintainerInstitution:
            productMaintainerInstitution,
        UserAndProductField.productDoneTimes: productDoneTimes,
        UserAndProductField.productMaintainerNote: productMaintainerNote,
        UserAndProductField.productMaintenanceType: productMaintenanceType,
        UserAndProductField.isTaskDone:isTaskDone
      };

  static UserAndProduct fromJson(Map<String, Object?> json) => UserAndProduct(
        tableId: json[UserAndProductField.tableId] as int?,
        userId: json[UserAndProductField.userId] as int?,
        productId: json[UserAndProductField.productId] as int?,
        productName: json[UserAndProductField.productName] as String,
        productOperationMethod:
            json[UserAndProductField.productOperationMethod] as String,
        productMaintainer:
            json[UserAndProductField.productMaintainer] as String,
        productMaintainerInstitution:
            json[UserAndProductField.productMaintainerInstitution] as String,
        productDoneTimes: json[UserAndProductField.productDoneTimes] as String,
        productMaintainerNote:
            json[UserAndProductField.productMaintainerNote] as String,
        productMaintenanceType:
            json[UserAndProductField.productMaintenanceType] as String,
        isTaskDone:
            json[UserAndProductField.isTaskDone] as int?,    
      );
}
