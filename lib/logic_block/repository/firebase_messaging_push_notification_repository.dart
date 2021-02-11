import 'package:rotation_app/logic_block/api/api.dart';

class FmcNotificationProvider{
  Future<dynamic> sendToken(params) async {
    return await Api.sendFmcTokenToServer(params);
  }
}