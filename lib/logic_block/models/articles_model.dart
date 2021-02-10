class Articles {
  int id;
  String type;
  String title;
  String shortContent;
  List<String> tags;
  String readOn;

  Articles(
      {this.id,
        this.type,
        this.title,
        this.shortContent,
        this.tags,
        this.readOn});

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    shortContent = json['short_content'];
    tags = json['tags'].cast<String>();
    readOn = json['read_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['tags'] = this.tags;
    data['read_on'] = this.readOn;
    return data;
  }
}


class MoreAboutArticle {
  int id;
  String type;
  String title;
  String shortContent;
  String content;
  String tags;
  String createdAt;
  String updatedAt;

  MoreAboutArticle(
      {this.id,
        this.type,
        this.title,
        this.shortContent,
        this.content,
        this.tags,
        this.createdAt,
        this.updatedAt});

  MoreAboutArticle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    shortContent = json['short_content'];
    content = json['content'];
    tags = json['tags'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['content'] = this.content;
    data['tags'] = this.tags;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}