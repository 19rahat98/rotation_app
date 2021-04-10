import 'package:flutter/material.dart';

class NotificationData {
  String id;
  String type;
  String notifiableType;
  int notifiableId;
  Data data;
  String readAt;
  String createdAt;
  String updatedAt;

  NotificationData(
      {this.id,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.data,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    readAt =  json['read_at'] != null ? json['read_at'] : '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  Head head;
  Body body;

  Data({this.head, this.body});

  Data.fromJson(Map<String, dynamic> json) {
    head = json['notification'] != null ? new Head.fromJson(json['notification']) : null;
    body = json['data'] != null ? new Body.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.head != null) {
      data['notification'] = this.head.toJson();
    }
    if (this.body != null) {
      data['data'] = this.body.toJson();
    }
    return data;
  }
}

class Head {
  String title;
  String body;

  Head({this.title, this.body});

  Head.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class Body {
  bool contentAvailable;
  String priority;
  String type;
  int id;
  int applicationId;
  int segmentId;
  bool isImportant;
  String title;
  String content;

  Body({
    this.contentAvailable,
    this.priority,
    this.type,
    this.id,
    this.segmentId,
    this.isImportant,
    this.title,
    this.content,
    this.applicationId,
  });

  Body.fromJson(Map<String, dynamic> json) {
    contentAvailable = json['content_available'];
    priority = json['priority'];
    type = json['type'];
    id = json['id'];
    applicationId = json['application_id'];
    segmentId = json['segment_id'];
    isImportant = json['is_important'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_available'] = this.contentAvailable;
    data['priority'] = this.priority;
    data['type'] = this.type;
    data['id'] = this.id;
    data['application_id'] = this.applicationId;
    data['segment_id'] = this.segmentId;
    data['is_important'] = this.isImportant;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}