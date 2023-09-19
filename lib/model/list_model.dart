// To parse this JSON data, do
//
//     final listModel = listModelFromJson(jsonString);

import 'dart:convert';

ListModel listModelFromJson(String str) => ListModel.fromJson(json.decode(str));

String listModelToJson(ListModel data) => json.encode(data.toJson());

class ListModel {
  ResponseData? responseData;
  String? statusMessage;
  int? statusCode;
  String? redirectTo;
  int? userId;

  ListModel({
    this.responseData,
    this.statusMessage,
    this.statusCode,
    this.redirectTo,
    this.userId,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
    responseData: json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
    statusMessage: json["statusMessage"],
    statusCode: json["statusCode"],
    redirectTo: json["redirectTo"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "responseData": responseData?.toJson(),
    "statusMessage": statusMessage,
    "statusCode": statusCode,
    "redirectTo": redirectTo,
    "userId": userId,
  };
}

class ResponseData {
  List<AdvancehistoryList>? patientDetails;
  List<AdvancehistoryList>? emergencyContact;
  List<LatestSymptom>? latestSymptoms;
  LatestMedications? latestMedications;
  List<dynamic>? medicalHistory;
  List<dynamic>? allergies;
  List<dynamic>? prescriptionMedications;
  List<dynamic>? takingAnyVitamins;
  List<FamilyHistory>? familyHistory;
  List<AdvancehistoryList>? dietAndNutritions;
  dynamic activityCharts;
  List<AdvancehistoryList>? lifestyle;
  List<LatestMedications>? treatments;
  List<Hospitalization>? hospitalizations;
  List<InsurancePolicy>? insurancePolicies;
  List<AdvancehistoryList>? advancehistoryList;
  List<dynamic>? illnessOrSurgeries;

  ResponseData({
    this.patientDetails,
    this.emergencyContact,
    this.latestSymptoms,
    this.latestMedications,
    this.medicalHistory,
    this.allergies,
    this.prescriptionMedications,
    this.takingAnyVitamins,
    this.familyHistory,
    this.dietAndNutritions,
    this.activityCharts,
    this.lifestyle,
    this.treatments,
    this.hospitalizations,
    this.insurancePolicies,
    this.advancehistoryList,
    this.illnessOrSurgeries,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    patientDetails: json["patientDetails"] == null ? [] : List<AdvancehistoryList>.from(json["patientDetails"]!.map((x) => AdvancehistoryList.fromJson(x))),
    emergencyContact: json["emergencyContact"] == null ? [] : List<AdvancehistoryList>.from(json["emergencyContact"]!.map((x) => AdvancehistoryList.fromJson(x))),
    latestSymptoms: json["latestSymptoms"] == null ? [] : List<LatestSymptom>.from(json["latestSymptoms"]!.map((x) => LatestSymptom.fromJson(x))),
    latestMedications: json["latestMedications"] == null ? null : LatestMedications.fromJson(json["latestMedications"]),
    medicalHistory: json["medicalHistory"] == null ? [] : List<dynamic>.from(json["medicalHistory"]!.map((x) => x)),
    allergies: json["allergies"] == null ? [] : List<dynamic>.from(json["allergies"]!.map((x) => x)),
    prescriptionMedications: json["prescriptionMedications"] == null ? [] : List<dynamic>.from(json["prescriptionMedications"]!.map((x) => x)),
    takingAnyVitamins: json["takingAnyVitamins"] == null ? [] : List<dynamic>.from(json["takingAnyVitamins"]!.map((x) => x)),
    familyHistory: json["familyHistory"] == null ? [] : List<FamilyHistory>.from(json["familyHistory"]!.map((x) => FamilyHistory.fromJson(x))),
    dietAndNutritions: json["dietAndNutritions"] == null ? [] : List<AdvancehistoryList>.from(json["dietAndNutritions"]!.map((x) => AdvancehistoryList.fromJson(x))),
    activityCharts: json["activityCharts"],
    lifestyle: json["lifestyle"] == null ? [] : List<AdvancehistoryList>.from(json["lifestyle"]!.map((x) => AdvancehistoryList.fromJson(x))),
    treatments: json["treatments"] == null ? [] : List<LatestMedications>.from(json["treatments"]!.map((x) => LatestMedications.fromJson(x))),
    hospitalizations: json["hospitalizations"] == null ? [] : List<Hospitalization>.from(json["hospitalizations"]!.map((x) => Hospitalization.fromJson(x))),
    insurancePolicies: json["insurancePolicies"] == null ? [] : List<InsurancePolicy>.from(json["insurancePolicies"]!.map((x) => InsurancePolicy.fromJson(x))),
    advancehistoryList: json["advancehistoryList"] == null ? [] : List<AdvancehistoryList>.from(json["advancehistoryList"]!.map((x) => AdvancehistoryList.fromJson(x))),
    illnessOrSurgeries: json["illnessOrSurgeries"] == null ? [] : List<dynamic>.from(json["illnessOrSurgeries"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "patientDetails": patientDetails == null ? [] : List<dynamic>.from(patientDetails!.map((x) => x.toJson())),
    "emergencyContact": emergencyContact == null ? [] : List<dynamic>.from(emergencyContact!.map((x) => x.toJson())),
    "latestSymptoms": latestSymptoms == null ? [] : List<dynamic>.from(latestSymptoms!.map((x) => x.toJson())),
    "latestMedications": latestMedications?.toJson(),
    "medicalHistory": medicalHistory == null ? [] : List<dynamic>.from(medicalHistory!.map((x) => x)),
    "allergies": allergies == null ? [] : List<dynamic>.from(allergies!.map((x) => x)),
    "prescriptionMedications": prescriptionMedications == null ? [] : List<dynamic>.from(prescriptionMedications!.map((x) => x)),
    "takingAnyVitamins": takingAnyVitamins == null ? [] : List<dynamic>.from(takingAnyVitamins!.map((x) => x)),
    "familyHistory": familyHistory == null ? [] : List<dynamic>.from(familyHistory!.map((x) => x.toJson())),
    "dietAndNutritions": dietAndNutritions == null ? [] : List<dynamic>.from(dietAndNutritions!.map((x) => x.toJson())),
    "activityCharts": activityCharts,
    "lifestyle": lifestyle == null ? [] : List<dynamic>.from(lifestyle!.map((x) => x.toJson())),
    "treatments": treatments == null ? [] : List<dynamic>.from(treatments!.map((x) => x.toJson())),
    "hospitalizations": hospitalizations == null ? [] : List<dynamic>.from(hospitalizations!.map((x) => x.toJson())),
    "insurancePolicies": insurancePolicies == null ? [] : List<dynamic>.from(insurancePolicies!.map((x) => x.toJson())),
    "advancehistoryList": advancehistoryList == null ? [] : List<dynamic>.from(advancehistoryList!.map((x) => x.toJson())),
    "illnessOrSurgeries": illnessOrSurgeries == null ? [] : List<dynamic>.from(illnessOrSurgeries!.map((x) => x)),
  };
}

class AdvancehistoryList {
  int? userId;
  int? questionId;
  String? question;
  String? answer;
  String? header;
  String? answerId;
  int? questionGroupId;

  AdvancehistoryList({
    this.userId,
    this.questionId,
    this.question,
    this.answer,
    this.header,
    this.answerId,
    this.questionGroupId,
  });

  factory AdvancehistoryList.fromJson(Map<String, dynamic> json) => AdvancehistoryList(
    userId: json["userId"],
    questionId: json["questionId"],
    question: json["question"],
    answer: json["answer"],
    header: json["header"]!,
    answerId: json["answerId"],
    questionGroupId: json["questionGroupId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "questionId": questionId,
    "question": question,
    "answer": answer,
    "header": header,
    "answerId": answerId,
    "questionGroupId": questionGroupId,
  };
}


class FamilyHistory {
  int? userId;
  String? header;
  String? familyMember;
  String? majorIllnessHeader;
  String? majorIllness;
  int? answerTableRowId;

  FamilyHistory({
    this.userId,
    this.header,
    this.familyMember,
    this.majorIllnessHeader,
    this.majorIllness,
    this.answerTableRowId,
  });

  factory FamilyHistory.fromJson(Map<String, dynamic> json) => FamilyHistory(
    userId: json["userId"],
    header: json["header"],
    familyMember: json["familyMember"],
    majorIllnessHeader: json["majorIllnessHeader"],
    majorIllness: json["majorIllness"],
    answerTableRowId: json["answerTableRowId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "header": header,
    "familyMember": familyMember,
    "majorIllnessHeader": majorIllnessHeader,
    "majorIllness": majorIllness,
    "answerTableRowId": answerTableRowId,
  };
}

class Hospitalization {
  int? userId;
  String? header;
  String? admissionDate;
  String? hospitalName;
  String? chiefComplaint;

  Hospitalization({
    this.userId,
    this.header,
    this.admissionDate,
    this.hospitalName,
    this.chiefComplaint,
  });

  factory Hospitalization.fromJson(Map<String, dynamic> json) => Hospitalization(
    userId: json["userId"],
    header: json["header"],
    admissionDate: json["admissionDate"],
    hospitalName: json["hospitalName"],
    chiefComplaint: json["chiefComplaint"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "header": header,
    "admissionDate": admissionDate,
    "hospitalName": hospitalName,
    "chiefComplaint": chiefComplaint,
  };
}

class InsurancePolicy {
  int? userId;
  String? header;
  String? expiryDate;
  String? policynumber;
  String? insuranceCompanyName;

  InsurancePolicy({
    this.userId,
    this.header,
    this.expiryDate,
    this.policynumber,
    this.insuranceCompanyName,
  });

  factory InsurancePolicy.fromJson(Map<String, dynamic> json) => InsurancePolicy(
    userId: json["userId"],
    header: json["header"],
    expiryDate: json["expiryDate"],
    policynumber: json["policynumber"],
    insuranceCompanyName: json["insuranceCompanyName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "header": header,
    "expiryDate": expiryDate,
    "policynumber": policynumber,
    "insuranceCompanyName": insuranceCompanyName,
  };
}

class LatestMedications {
  int? userId;
  String? header;
  String? date;
  String? doctorName;
  String? medicineNames;
  String? treatmentName;

  LatestMedications({
    this.userId,
    this.header,
    this.date,
    this.doctorName,
    this.medicineNames,
    this.treatmentName,
  });

  factory LatestMedications.fromJson(Map<String, dynamic> json) => LatestMedications(
    userId: json["userId"],
    header: json["header"],
    date: json["date"],
    doctorName: json["doctorName"],
    medicineNames: json["medicineNames"],
    treatmentName: json["treatmentName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "header": header,
    "date": date,
    "doctorName": doctorName,
    "medicineNames": medicineNames,
    "treatmentName": treatmentName,
  };
}

class LatestSymptom {
  int? userId;
  String? header;
  int? symptomId;
  String? symptomName;
  String? createdOn;

  LatestSymptom({
    this.userId,
    this.header,
    this.symptomId,
    this.symptomName,
    this.createdOn,
  });

  factory LatestSymptom.fromJson(Map<String, dynamic> json) => LatestSymptom(
    userId: json["userId"],
    header: json["header"],
    symptomId: json["symptomId"],
    symptomName: json["symptomName"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "header": header,
    "symptomId": symptomId,
    "symptomName": symptomName,
    "createdOn": createdOn,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
