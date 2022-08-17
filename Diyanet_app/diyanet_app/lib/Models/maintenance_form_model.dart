import 'package:flutter/widgets.dart';

final String tableMaintenanceForm = 'forms';

class MaintenanceFormField {
  static final List<String> values = [
    /// Add all fields
    formId,
    formProductName,
    formMaintenanceDate,
    formMaintenancePassingTime,
    formExplanation,
    formPreventionAndSuggestion,
    formImprovementAreas,
    formResult,
    formMaintenanceResponsible,
    formPersonOfCheck
  ];

  static final String formId = "_id";
  static final String formProductName = "formProductName";
  static final String formMaintenanceDate = "formMaintenanceDate";
  static final String formMaintenancePassingTime = "formMaintenancePassingTime";
  static final String formExplanation = "formExplanation";
  static final String formPreventionAndSuggestion =
      "formPreventionAndSuggestion";
  static final String formImprovementAreas = "formImprovementAreas";
  static final String formResult = "formResult";
  static final String formMaintenanceResponsible = "formMaintenanceResponsible";
  static final String formPersonOfCheck = "formPersonOfCheck";
}

class MaintenanceForm {
  int? formId;
  String? formProductName;
  String? formMaintenanceDate;
  String? formMaintenancePassingTime;
  String? formExplanation;
  String? formPreventionAndSuggestion;
  String? formImprovementAreas;
  String? formResult;
  String? formMaintenanceResponsible;
  String? formPersonOfCheck;

  MaintenanceForm({
    this.formId,
    required this.formProductName,
    required this.formMaintenanceDate,
    required this.formMaintenancePassingTime,
    required this.formExplanation,
    required this.formPreventionAndSuggestion,
    required this.formImprovementAreas,
    required this.formResult,
    required this.formMaintenanceResponsible,
    required this.formPersonOfCheck,
  });

  MaintenanceForm copy({
    int? formId,
    String? formProductName,
    String? formMaintenanceDate,
    String? formMaintenancePassingTime,
    String? formExplanation,
    String? formPreventionAndSuggestion,
    String? formImprovementAreas,
    String? formResult,
    String? formMaintenanceResponsible,
    String? formPersonOfCheck,
  }) =>
      MaintenanceForm(
        formId: formId ?? this.formId,
        formProductName: formProductName ?? this.formProductName,
        formMaintenanceDate: formMaintenanceDate ?? this.formMaintenanceDate,
        formMaintenancePassingTime:
            formMaintenancePassingTime ?? this.formMaintenancePassingTime,
        formExplanation: formExplanation ?? this.formExplanation,
        formPreventionAndSuggestion:
            formPreventionAndSuggestion ?? this.formPreventionAndSuggestion,
        formImprovementAreas: formImprovementAreas ?? this.formImprovementAreas,
        formResult: formResult ?? this.formResult,
        formMaintenanceResponsible:
            formMaintenanceResponsible ?? this.formMaintenanceResponsible,
        formPersonOfCheck: formPersonOfCheck ?? this.formPersonOfCheck,
      );

  Map<String, Object?> toJson() => {
        MaintenanceFormField.formId: formId,
        MaintenanceFormField.formProductName: formProductName,
        MaintenanceFormField.formMaintenanceDate: formMaintenanceDate,
        MaintenanceFormField.formMaintenancePassingTime:
            formMaintenancePassingTime,
        MaintenanceFormField.formExplanation: formExplanation,
        MaintenanceFormField.formPreventionAndSuggestion:
            formPreventionAndSuggestion,
        MaintenanceFormField.formImprovementAreas: formImprovementAreas,
        MaintenanceFormField.formResult: formResult,
        MaintenanceFormField.formMaintenanceResponsible:
            formMaintenanceResponsible,
        MaintenanceFormField.formPersonOfCheck: formPersonOfCheck,
      };

  static MaintenanceForm fromJson(Map<String, Object?> json) => MaintenanceForm(
        formId: json[MaintenanceFormField.formId] as int?,
        formProductName: json[MaintenanceFormField.formProductName] as String,
        formMaintenanceDate:
            json[MaintenanceFormField.formMaintenanceDate] as String,
        formMaintenancePassingTime:
            json[MaintenanceFormField.formMaintenancePassingTime] as String,
        formExplanation: json[MaintenanceFormField.formExplanation] as String,
        formPreventionAndSuggestion:
            json[MaintenanceFormField.formPreventionAndSuggestion] as String,
        formImprovementAreas:
            json[MaintenanceFormField.formImprovementAreas] as String,
        formResult: json[MaintenanceFormField.formResult] as String,
        formMaintenanceResponsible:
            json[MaintenanceFormField.formMaintenanceResponsible] as String,
        formPersonOfCheck: json[MaintenanceFormField.formPersonOfCheck] as String,
      );
}
