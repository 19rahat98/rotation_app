import 'package:rotation_app/logic_block/api/api.dart';

class QuestionRepository{
  Future<dynamic> questionsFromDB() async {
    return await Api.getQuestions();
  }
}