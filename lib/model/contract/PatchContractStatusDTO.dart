class PatchContractStatusDTO {
  int? id;
  String? status;
  int? revocationReasonId;

  PatchContractStatusDTO({this.id, this.status, this.revocationReasonId});

  PatchContractStatusDTO.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        status = json['status'],
        revocationReasonId = json['revocationReasonId'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['status'] = this.status;
    map['revocationReasonId'] = this.revocationReasonId;
    return map;
  }
}
