import 'package:rotation_app/logic_block/api/api.dart';

class ArticlesListRepository{
  Future<dynamic> articlesFromDB({int pageNumber, int perPage}) async {
    final params = {
      "page": pageNumber != null ? pageNumber : 1,
      "per_page": perPage != null ? perPage : 10,
    };
    return await Api.getArticlesList(params);
  }

  Future<dynamic> aboutMore({String id}) async {
    return await Api.aboutMoreArticle(id: id);
  }

   Future<dynamic> markAsReadNews({String id}) async {
    return await Api.markAsReadNews(idArticle: id);
  }



}