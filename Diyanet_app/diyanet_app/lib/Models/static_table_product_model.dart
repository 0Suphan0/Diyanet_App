// final String tableStaticProduct = 'staticProducts';

// class StaticProductField {
//   static final List<String> values = [
//     /// Add all fields
//     productId,
//     productName,
//     productOperationMethod,
//     productMaintainer,
//     productMaintainerInstitution,
//     productDoneTimes,
//     productMaintainerNote,
//     productMaintenanceType
//   ];

//   static final String productId = "_id";
//   static final String productName = "productName";
//   static final String productOperationMethod = "productOperationMethod";
//   static final String productMaintainer = "productMaintainer";
//   static final String productMaintainerInstitution =
//       "productMaintainerInstitution";
//   static final String productDoneTimes = "productDoneTimes";
//   static final String productMaintainerNote = "productMaintainerNote";
//   static final String productMaintenanceType = "productMaintenanceType";
// }

// class StaticProduct {
//   int? productId;
//   String? productName;
//   String? productOperationMethod;
//   String? productMaintainer;
//   String? productMaintainerInstitution;
//   String? productDoneTimes;
//   String? productMaintainerNote;
//   String? productMaintenanceType;

//   StaticProduct({
//     this.productId,
//    required this.productName,
//    required this.productOperationMethod,
//    required this.productMaintainer,
//    required this.productMaintainerInstitution,
//    required this.productDoneTimes,
//    required this.productMaintainerNote,
//    required this.productMaintenanceType,
//   });

//    StaticProduct copy({
//   int? productId,
//   String? productName,
//   String? productOperationMethod,
//   String? productMaintainer,
//   String? productMaintainerInstitution,
//   String? productDoneTimes,
//   String? productMaintainerNote,
//   String? productMaintenanceType,
//   }) =>
//       StaticProduct(
//         productId: productId ?? this.productId,
//         productName: productName ?? this.productName,
//         productOperationMethod: productOperationMethod ?? this.productOperationMethod,
//         productMaintainer: productMaintainer ?? this.productMaintainer,
//         productMaintainerInstitution: productMaintainerInstitution ?? this.productMaintainerInstitution,
//         productDoneTimes: productDoneTimes ?? this.productDoneTimes,
//         productMaintainerNote: productMaintainerNote ?? this.productMaintainerNote,
//         productMaintenanceType: productMaintenanceType ?? this.productMaintenanceType,

//       );
  

//   Map<String, Object?> toJson() => {
//         StaticProductField.productId: productId,
//         StaticProductField.productName: productName,
//         StaticProductField.productOperationMethod: productOperationMethod,
//         StaticProductField.productMaintainer: productMaintainer,
//         StaticProductField.productMaintainerInstitution: productMaintainerInstitution,
//         StaticProductField.productDoneTimes: productDoneTimes,
//         StaticProductField.productMaintainerNote: productMaintainerNote,
//         StaticProductField.productMaintenanceType: productMaintenanceType,
//       };

//   static StaticProduct fromJson(Map<String, Object?> json) => StaticProduct(
//         productId: json[StaticProductField.productId] as int?,
//         productName: json[StaticProductField.productName] as String,
//         productOperationMethod: json[StaticProductField.productOperationMethod] as String,
//         productMaintainer: json[StaticProductField.productMaintainer] as String,
//         productMaintainerInstitution: json[StaticProductField.productMaintainerInstitution] as String,
//         productDoneTimes: json[StaticProductField.productDoneTimes] as String,
//         productMaintainerNote: json[StaticProductField.productMaintainerNote] as String,
//         productMaintenanceType: json[StaticProductField.productMaintenanceType] as String,
//       );
// }
