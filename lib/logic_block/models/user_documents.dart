class Documents {
  int id;
  int employeeId;
  String type;
  String number;
  String issueDate;
  String expireDate;
  String issueBy;
  String createdAt;
  String updatedAt;

  Documents(
      {this.id,
        this.employeeId,
        this.type,
        this.number,
        this.issueDate,
        this.expireDate,
        this.issueBy,
        this.createdAt,
        this.updatedAt});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    type = json['type'];
    number = json['number'];
    issueDate = json['issue_date'];
    expireDate = json['expire_date'];
    issueBy = json['issue_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['type'] = this.type;
    data['number'] = this.number;
    data['issue_date'] = this.issueDate;
    data['expire_date'] = this.expireDate;
    data['issue_by'] = this.issueBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}