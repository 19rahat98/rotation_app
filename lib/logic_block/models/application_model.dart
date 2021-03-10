class Application {
  int id;
  int userId;
  int bookingId;
  dynamic groupApplicationId;
  int employeeId;
  bool isExtra;
  String startStationCode;
  String endStationCode;
  String direction;
  String shift;
  String date;
  int startHours;
  int endHours;
  String searchBy;
  String status;
  int isApproved;
  String createdAt;
  String updatedAt;
  bool fromOld;
  dynamic oldId;
  dynamic deletedAt;
  bool isStored;
  String issuedAt;
  int businessTripDays;
  String startStation;
  String endStation;
  String productKey;
  int overTime;
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
        this.issuedAt,
        this.businessTripDays,
        this.startStation,
        this.endStation,
        this.productKey,
        this.overTime,
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
    issuedAt = json['issued_at'];
    businessTripDays = json['business_trip_days'];
    startStation = json['start_station'];
    endStation = json['end_station'];
    productKey = json['product_key'];
    overTime = json['overtime'];
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
    data['issued_at'] = this.issuedAt;
    data['business_trip_days'] = this.businessTripDays;
    data['start_station'] = this.startStation;
    data['end_station'] = this.endStation;
    data['product_key'] = this.productKey;
    data['overtime'] = this.overTime;
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
  String activeProcess;
  int ticketId;
  dynamic closedReason;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String depStation;
  String arrStation;
  dynamic watcherTimeLimit;
  String icon;
  Train train;
  Ticket ticket;

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
        this.watcherTimeLimit,
        this.icon,
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
    watcherTimeLimit = json['watcher_time_limit'];
    icon = json['icon'];
    train = json['train'] != null ? new Train.fromJson(json['train']) : null;
    ticket =
    json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
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
    data['watcher_time_limit'] = this.watcherTimeLimit;
    data['icon'] = this.icon;
    if (this.train != null) {
      data['train'] = this.train.toJson();
    }
    if (this.ticket != null) {
      data['ticket'] = this.ticket.toJson();
    }
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

class Ticket {
  int id;
  int orderId;
  int apiOrderId;
  String expressId;
  String docNumber;
  String docType;
  String depStationCode;
  String depStationName;
  String arrStationCode;
  String arrStationName;
  String trainNumber;
  String trainDisplayNumber;
  int isTalgoTrain;
  String depDateTime;
  String arrDateTime;
  int carType;
  String carNumber;
  String carClass;
  String carDetail;
  String seatNumber;
  dynamic placeLevel;
  int placeOtsekNumber;
  String carrierName;
  int distance;
  int minPrice;
  int maxPrice;
  int sum;
  dynamic returnUserId;
  dynamic returnSum;
  dynamic returnCommission;
  String returnedAt;
  String status;
  int bookUserId;
  String bookedAt;
  int issueUserId;
  String issuedAt;
  int travcomIssueDownload;
  int travcomRefundDownload;
  dynamic additionalInfo;
  int fromOld;
  String placeSelectType;
  dynamic categoryPlaceParamId;
  bool byWatcher;
  dynamic categoryName;
  dynamic categoryPlaceParam;
  dynamic categoryPlaceParamInd;
  String ticketUrl;
  String seatLevel;
  String carTypeLabel;
  List<Places> places;

  Ticket(
      {this.id,
        this.orderId,
        this.apiOrderId,
        this.expressId,
        this.docNumber,
        this.docType,
        this.depStationCode,
        this.depStationName,
        this.arrStationCode,
        this.arrStationName,
        this.trainNumber,
        this.trainDisplayNumber,
        this.isTalgoTrain,
        this.depDateTime,
        this.arrDateTime,
        this.carType,
        this.carNumber,
        this.carClass,
        this.carDetail,
        this.seatNumber,
        this.placeLevel,
        this.placeOtsekNumber,
        this.carrierName,
        this.distance,
        this.minPrice,
        this.maxPrice,
        this.sum,
        this.returnUserId,
        this.returnSum,
        this.returnCommission,
        this.returnedAt,
        this.status,
        this.bookUserId,
        this.bookedAt,
        this.issueUserId,
        this.issuedAt,
        this.travcomIssueDownload,
        this.travcomRefundDownload,
        this.additionalInfo,
        this.fromOld,
        this.placeSelectType,
        this.categoryPlaceParamId,
        this.byWatcher,
        this.categoryName,
        this.categoryPlaceParam,
        this.categoryPlaceParamInd,
        this.ticketUrl,
        this.seatLevel,
        this.carTypeLabel,
        this.places});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    apiOrderId = json['api_order_id'];
    expressId = json['express_id'];
    docNumber = json['doc_number'];
    docType = json['doc_type'];
    depStationCode = json['dep_station_code'];
    depStationName = json['dep_station_name'];
    arrStationCode = json['arr_station_code'];
    arrStationName = json['arr_station_name'];
    trainNumber = json['train_number'];
    trainDisplayNumber = json['train_display_number'];
    isTalgoTrain = json['is_talgo_train'];
    depDateTime = json['dep_date_time'];
    arrDateTime = json['arr_date_time'];
    carType = json['car_type'];
    carNumber = json['car_number'];
    carClass = json['car_class'];
    carDetail = json['car_detail'];
    seatNumber = json['seat_number'];
    placeLevel = json['place_level'];
    placeOtsekNumber = json['place_otsek_number'];
    carrierName = json['carrier_name'];
    distance = json['distance'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    sum = json['sum'];
    returnUserId = json['return_user_id'];
    returnSum = json['return_sum'];
    returnCommission = json['return_commission'];
    returnedAt = json['returned_at'];
    status = json['status'];
    bookUserId = json['book_user_id'];
    bookedAt = json['booked_at'];
    issueUserId = json['issue_user_id'];
    issuedAt = json['issued_at'];
    travcomIssueDownload = json['travcom_issue_download'];
    travcomRefundDownload = json['travcom_refund_download'];
    additionalInfo = json['additional_info'];
    fromOld = json['from_old'];
    placeSelectType = json['place_select_type'];
    categoryPlaceParamId = json['category_place_param_id'];
    byWatcher = json['by_watcher'];
    categoryName = json['category_name'];
    categoryPlaceParam = json['category_place_param'];
    categoryPlaceParamInd = json['category_place_param_ind'];
    ticketUrl = json['ticket_url'];
    seatLevel = json['seat_level'];
    carTypeLabel = json['car_type_label'];
    if (json['places'] != null) {
      places = new List<Places>();
      json['places'].forEach((v) {
        places.add(new Places.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['api_order_id'] = this.apiOrderId;
    data['express_id'] = this.expressId;
    data['doc_number'] = this.docNumber;
    data['doc_type'] = this.docType;
    data['dep_station_code'] = this.depStationCode;
    data['dep_station_name'] = this.depStationName;
    data['arr_station_code'] = this.arrStationCode;
    data['arr_station_name'] = this.arrStationName;
    data['train_number'] = this.trainNumber;
    data['train_display_number'] = this.trainDisplayNumber;
    data['is_talgo_train'] = this.isTalgoTrain;
    data['dep_date_time'] = this.depDateTime;
    data['arr_date_time'] = this.arrDateTime;
    data['car_type'] = this.carType;
    data['car_number'] = this.carNumber;
    data['car_class'] = this.carClass;
    data['car_detail'] = this.carDetail;
    data['seat_number'] = this.seatNumber;
    data['place_level'] = this.placeLevel;
    data['place_otsek_number'] = this.placeOtsekNumber;
    data['carrier_name'] = this.carrierName;
    data['distance'] = this.distance;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['sum'] = this.sum;
    data['return_user_id'] = this.returnUserId;
    data['return_sum'] = this.returnSum;
    data['return_commission'] = this.returnCommission;
    data['returned_at'] = this.returnedAt;
    data['status'] = this.status;
    data['book_user_id'] = this.bookUserId;
    data['booked_at'] = this.bookedAt;
    data['issue_user_id'] = this.issueUserId;
    data['issued_at'] = this.issuedAt;
    data['travcom_issue_download'] = this.travcomIssueDownload;
    data['travcom_refund_download'] = this.travcomRefundDownload;
    data['additional_info'] = this.additionalInfo;
    data['from_old'] = this.fromOld;
    data['place_select_type'] = this.placeSelectType;
    data['category_place_param_id'] = this.categoryPlaceParamId;
    data['by_watcher'] = this.byWatcher;
    data['category_name'] = this.categoryName;
    data['category_place_param'] = this.categoryPlaceParam;
    data['category_place_param_ind'] = this.categoryPlaceParamInd;
    data['ticket_url'] = this.ticketUrl;
    data['seat_level'] = this.seatLevel;
    data['car_type_label'] = this.carTypeLabel;
    if (this.places != null) {
      data['places'] = this.places.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Places {
  int id;
  int ticketId;
  int number;
  dynamic level;
  dynamic categoryName;
  dynamic categoryPlaceParam;
  dynamic categoryPlaceParamInd;
  String createdAt;
  String updatedAt;
  String type;
  int floor;
  int compNumber;
  int isBorder;

  Places(
      {this.id,
        this.ticketId,
        this.number,
        this.level,
        this.categoryName,
        this.categoryPlaceParam,
        this.categoryPlaceParamInd,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.floor,
        this.compNumber,
        this.isBorder});

  Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    number = json['number'];
    level = json['level'];
    categoryName = json['category_name'];
    categoryPlaceParam = json['category_place_param'];
    categoryPlaceParamInd = json['category_place_param_ind'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    floor = json['floor'];
    compNumber = json['comp_number'];
    isBorder = json['is_border'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['number'] = this.number;
    data['level'] = this.level;
    data['category_name'] = this.categoryName;
    data['category_place_param'] = this.categoryPlaceParam;
    data['category_place_param_ind'] = this.categoryPlaceParamInd;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['floor'] = this.floor;
    data['comp_number'] = this.compNumber;
    data['is_border'] = this.isBorder;
    return data;
  }
}