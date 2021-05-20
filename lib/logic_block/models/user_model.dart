/*class User {
  String token;
  Employee employee;

  User({this.token, this.employee});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.employee != null) {
      data['employee'] = this.employee.toJson();
    }
    return data;
  }
}*/

class Employee {
  int id;
  String firstName;
  String lastName;
  String orgName;
  String patronymic;
  String firstNameEn;
  String lastNameEn;
  String iin;
  String position;
  String factoryName;
  String shiftName;
  String docType;
  String docNumber;
  String homeStation;
  String countryCode;
  bool isPhoneNumber;
  String gender;
  String birthDate;

  Employee(
      {this.id,
        this.firstName,
        this.lastName,
        this.patronymic,
        this.firstNameEn,
        this.lastNameEn,
        this.iin,
        this.position,
        this.factoryName,
        this.shiftName,
        this.docType,
        this.docNumber,
        this.homeStation,
        this.orgName,
        this.countryCode,
        this.isPhoneNumber,
        this.gender,
        this.birthDate,
      });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : '';
    firstName = json['first_name'];
    lastName = json['last_name'];
    patronymic = json['patronymic'];
    firstNameEn = json['first_name_en'];
    lastNameEn = json['last_name_en'];
    iin = json['iin'];
    position = json['position'];
    factoryName = json['factory_name'];
    shiftName = json['shift_name'];
    docType = json['doc_type'];
    docNumber = json['number'];
    homeStation = json['home_station'];
    orgName = json['org_name'];
    countryCode = json['country_code'];
    isPhoneNumber = json['is_phone_number'];
    gender = json['gender'];
    birthDate = json['birth_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['patronymic'] = this.patronymic;
    data['first_name_en'] = this.firstNameEn;
    data['last_name_en'] = this.lastNameEn;
    data['iin'] = this.iin;
    data['position'] = this.position;
    data['factory_name'] = this.factoryName;
    data['shift_name'] = this.shiftName;
    data['doc_type'] = this.docType;
    data['number'] = this.docNumber;
    data['home_station'] = this.homeStation;
    data['org_name'] = this.orgName;
    data['country_code'] = this.countryCode;
    data['is_phone_number'] = this.isPhoneNumber;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    return data;
  }
}