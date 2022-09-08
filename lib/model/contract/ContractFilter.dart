class ContractFilter {
  String? id;
  int? page;
  int? pageSize;

  ContractFilter();

  ContractFilter.fromJson(Map<String?, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['page'] = this.page;
    map['pageSize'] = this.pageSize;
    return map;
  }
}
