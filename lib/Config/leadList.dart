// To parse this JSON data, do
//
//     final leadListModel = leadListModelFromJson(jsonString);

import 'dart:convert';

LeadListModel leadListModelFromJson(String str) =>
    LeadListModel.fromJson(json.decode(str));

String leadListModelToJson(LeadListModel data) => json.encode(data.toJson());

class LeadListModel {
  LeadListModel({
    this.type,
    this.createdOn,
    this.totalAppts,
    this.completedAppts,
    this.id,
    this.email,
    this.notaryId,
    this.name,
    this.companyName,
    this.phoneNumber,
    this.companyAddress,
    this.v,
  });

  String type;
  DateTime createdOn;
  int totalAppts;
  int completedAppts;
  String id;
  String email;
  String notaryId;
  String name;
  String companyName;
  int phoneNumber;
  String companyAddress;
  int v;

  factory LeadListModel.fromJson(Map<String, dynamic> json) => LeadListModel(
        type: json["type"],
        createdOn: DateTime.parse(json["createdOn"]),
        totalAppts: json["totalAppts"],
        completedAppts: json["completedAppts"],
        id: json["_id"],
        email: json["email"],
        notaryId: json["notaryId"],
        name: json["name"],
        companyName: json["companyName"],
        phoneNumber: json["PhoneNumber"],
        companyAddress: json["companyAddress"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "createdOn": createdOn.toIso8601String(),
        "totalAppts": totalAppts,
        "completedAppts": completedAppts,
        "_id": id,
        "email": email,
        "notaryId": notaryId,
        "name": name,
        "companyName": companyName,
        "PhoneNumber": phoneNumber,
        "companyAddress": companyAddress,
        "__v": v,
      };
}
