class Application {
  int id;
  int userId;
  int bookingId;
  int groupApplicationId;
  int employeeId;
  bool isExtra;
  String startStationCode;
  String endStationCode;
  String direction;
  String shift;
  String date;
  int startHours;
  int endHours;
  Null searchBy;
  String status;
  int isApproved;
  String createdAt;
  String updatedAt;
  bool fromOld;
  Null oldId;
  Null deletedAt;
  bool isStored;
  String startStation;
  String endStation;
  List<Segments> segments;

  Application(
      {this.id,
        this.userId,
        this.bookingId,
        this.groupApplicationId,
        this.employeeId,
        this.isExtra,
        this.startStationCode,
        this.endStationCode,
        this.direction,
        this.shift,
        this.date,
        this.startHours,
        this.endHours,
        this.searchBy,
        this.status,
        this.isApproved,
        this.createdAt,
        this.updatedAt,
        this.fromOld,
        this.oldId,
        this.deletedAt,
        this.isStored,
        this.startStation,
        this.endStation,
        this.segments});

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    groupApplicationId = json['group_application_id'];
    employeeId = json['employee_id'];
    isExtra = json['is_extra'];
    startStationCode = json['start_station_code'];
    endStationCode = json['end_station_code'];
    direction = json['direction'];
    shift = json['shift'];
    date = json['date'];
    startHours = json['start_hours'];
    endHours = json['end_hours'];
    searchBy = json['search_by'];
    status = json['status'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromOld = json['from_old'];
    oldId = json['old_id'];
    deletedAt = json['deleted_at'];
    isStored = json['is_stored'];
    startStation = json['start_station'];
    endStation = json['end_station'];
    if (json['segments'] != null) {
      segments = new List<Segments>();
      json['segments'].forEach((v) {
        segments.add(new Segments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['group_application_id'] = this.groupApplicationId;
    data['employee_id'] = this.employeeId;
    data['is_extra'] = this.isExtra;
    data['start_station_code'] = this.startStationCode;
    data['end_station_code'] = this.endStationCode;
    data['direction'] = this.direction;
    data['shift'] = this.shift;
    data['date'] = this.date;
    data['start_hours'] = this.startHours;
    data['end_hours'] = this.endHours;
    data['search_by'] = this.searchBy;
    data['status'] = this.status;
    data['is_approved'] = this.isApproved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_old'] = this.fromOld;
    data['old_id'] = this.oldId;
    data['deleted_at'] = this.deletedAt;
    data['is_stored'] = this.isStored;
    data['start_station'] = this.startStation;
    data['end_station'] = this.endStation;
    if (this.segments != null) {
      data['segments'] = this.segments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Segments {
  int id;
  int applicationId;
  String depStationCode;
  String depStationName;
  String arrStationCode;
  String arrStationName;
  String status;
  Null activeProcess;
  Null ticketId;
  Null closedReason;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String depStation;
  String arrStation;
  Train train;
  Null ticket;

  Segments(
      {this.id,
        this.applicationId,
        this.depStationCode,
        this.depStationName,
        this.arrStationCode,
        this.arrStationName,
        this.status,
        this.activeProcess,
        this.ticketId,
        this.closedReason,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.depStation,
        this.arrStation,
        this.train,
        this.ticket});

  Segments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationId = json['application_id'];
    depStationCode = json['dep_station_code'];
    depStationName = json['dep_station_name'];
    arrStationCode = json['arr_station_code'];
    arrStationName = json['arr_station_name'];
    status = json['status'];
    activeProcess = json['active_process'];
    ticketId = json['ticket_id'];
    closedReason = json['closed_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    depStation = json['dep_station'];
    arrStation = json['arr_station'];
    train = json['train'] != null ? new Train.fromJson(json['train']) : null;
    ticket = json['ticket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['application_id'] = this.applicationId;
    data['dep_station_code'] = this.depStationCode;
    data['dep_station_name'] = this.depStationName;
    data['arr_station_code'] = this.arrStationCode;
    data['arr_station_name'] = this.arrStationName;
    data['status'] = this.status;
    data['active_process'] = this.activeProcess;
    data['ticket_id'] = this.ticketId;
    data['closed_reason'] = this.closedReason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['dep_station'] = this.depStation;
    data['arr_station'] = this.arrStation;
    if (this.train != null) {
      data['train'] = this.train.toJson();
    }
    data['ticket'] = this.ticket;
    return data;
  }
}

class Train {
  int id;
  int segmentId;
  String depStationCode;
  String depStationName;
  String arrStationCode;
  String arrStationName;
  String number;
  String displayNumber;
  bool isTalgo;
  String depDateTime;
  String arrDateTime;
  bool withElReg;
  int inWayMinutes;
  String createdAt;
  String updatedAt;
  String depStation;
  String arrStation;

  Train(
      {this.id,
        this.segmentId,
        this.depStationCode,
        this.depStationName,
        this.arrStationCode,
        this.arrStationName,
        this.number,
        this.displayNumber,
        this.isTalgo,
        this.depDateTime,
        this.arrDateTime,
        this.withElReg,
        this.inWayMinutes,
        this.createdAt,
        this.updatedAt,
        this.depStation,
        this.arrStation});

  Train.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    segmentId = json['segment_id'];
    depStationCode = json['dep_station_code'];
    depStationName = json['dep_station_name'];
    arrStationCode = json['arr_station_code'];
    arrStationName = json['arr_station_name'];
    number = json['number'];
    displayNumber = json['display_number'];
    isTalgo = json['is_talgo'];
    depDateTime = json['dep_date_time'];
    arrDateTime = json['arr_date_time'];
    withElReg = json['with_el_reg'];
    inWayMinutes = json['in_way_minutes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    depStation = json['dep_station'];
    arrStation = json['arr_station'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['segment_id'] = this.segmentId;
    data['dep_station_code'] = this.depStationCode;
    data['dep_station_name'] = this.depStationName;
    data['arr_station_code'] = this.arrStationCode;
    data['arr_station_name'] = this.arrStationName;
    data['number'] = this.number;
    data['display_number'] = this.displayNumber;
    data['is_talgo'] = this.isTalgo;
    data['dep_date_time'] = this.depDateTime;
    data['arr_date_time'] = this.arrDateTime;
    data['with_el_reg'] = this.withElReg;
    data['in_way_minutes'] = this.inWayMinutes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dep_station'] = this.depStation;
    data['arr_station'] = this.arrStation;
    return data;
  }
}