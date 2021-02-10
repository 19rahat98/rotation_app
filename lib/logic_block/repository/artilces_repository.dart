import 'package:rotation_app/logic_block/api/api.dart';

class ArticlesListRepository{
  Future<dynamic> articlesFromDB() async {
    return await Api.getArticlesList();
  }

  Future<dynamic> aboutMore({int id}) async {
    return await Api.aboutMoreArticle(id: id);
  }

}