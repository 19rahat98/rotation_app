class NotificationItem{
  bool isImportant;
  String title;
  String type;
  String priority;
  int id;
  String content;
  int segmentId;
  bool contentAvailable;

  NotificationItem({
    this.id,
    this.type,
    this.content,
    this.title,
    this.contentAvailable,
    this.isImportant,
    this.priority,
    this.segmentId,
  });

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    title = json['title'];
    contentAvailable = json['content_available'];
    isImportant = json['is_important'];
    priority = json['priority'];
    segmentId = json['segment_id'];
  }
}