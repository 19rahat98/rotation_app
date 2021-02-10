import 'package:rotation_app/logic_block/api/api.dart';

class ConversationRatesRepository{
  Future<dynamic> getEUR() async {
    return await Api.getConversationEUR();
  }

  Future<dynamic> getUSD() async {
    return await Api.getConversationUSD();
  }

}