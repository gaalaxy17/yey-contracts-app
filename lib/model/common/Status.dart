class Status {
  String? label;
  String? value;

  Status({this.label, this.value});

  Status.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        value = json['value'];
}
