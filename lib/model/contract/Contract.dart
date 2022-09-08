import 'package:teste/model/common/Status.dart';

class Contract {
  int? id;
  String? customerName;
  String? companyName;
  String? schoolName;
  double? wage;
  DateTime? startDate;
  DateTime? endDate;
  Status? status;

  Contract(
      {this.id,
      this.customerName,
      this.companyName,
      this.schoolName,
      this.wage,
      this.startDate,
      this.endDate,
      this.status});

  Contract.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        customerName = json['customerName'],
        companyName = json['companyName'],
        schoolName = json['schoolName'],
        wage = double.tryParse(json['wage']),
        startDate = DateTime.tryParse(json['startDate']),
        endDate = DateTime.tryParse(json['endDate']),
        status = Status.fromJson(json['status']);
}
