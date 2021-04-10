import 'package:rotation_app/logic_block/api/api.dart';

class ArticlesListRepository{
  Future<dynamic> articlesFromDB() async {
    return await Api.getArticlesList();
  }

  Future<dynamic> aboutMore({String id}) async {
    return await Api.aboutMoreArticle(id: id);
  }

   Future<dynamic> markAsReadNews({String id}) async {
    return await Api.markAsReadNews(idArticle: id);
  }



}