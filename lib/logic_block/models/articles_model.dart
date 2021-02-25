class Articles {
  int id;
  String title;
  String shortContent;
  String publishedOn;
  String readOn;
  String shortTitle;
  Pivot pivot;

  Articles(
      {this.id,
        this.title,
        this.shortContent,
        this.publishedOn,
        this.readOn,
        this.shortTitle,
        this.pivot});

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortContent = json['short_content'];
    publishedOn = json['published_on'];
    readOn = json['read_on'];
    shortTitle = json['short_title'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['published_on'] = this.publishedOn;
    data['read_on'] = this.readOn;
    data['short_title'] = this.shortTitle;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int siteId;
  int articleId;

  Pivot({this.siteId, this.articleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    siteId = json['site_id'];
    articleId = json['article_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site_id'] = this.siteId;
    data['article_id'] = this.articleId;
    return data;
  }
}


class MoreAboutArticle {
  int id;
  dynamic userId;
  dynamic publishedUserId;
  int typeId;
  String title;
  String shortContent;
  String content;
  dynamic display;
  String publishedOn;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  dynamic shortTitle;

  MoreAboutArticle(
      {this.id,
        this.userId,
        this.publishedUserId,
        this.typeId,
        this.title,
        this.shortContent,
        this.content,
        this.display,
        this.publishedOn,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.shortTitle});

  MoreAboutArticle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    publishedUserId = json['published_user_id'];
    typeId = json['type_id'];
    title = json['title'];
    shortContent = json['short_content'];
    content = json['content'];
    display = json['display'];
    publishedOn = json['published_on'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    shortTitle = json['short_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['published_user_id'] = this.publishedUserId;
    data['type_id'] = this.typeId;
    data['title'] = this.title;
    data['short_content'] = this.shortContent;
    data['content'] = this.content;
    data['display'] = this.display;
    data['published_on'] = this.publishedOn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['short_title'] = this.shortTitle;
    return data;
  }
}

