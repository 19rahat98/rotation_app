class Preferences {
  static String userToken = 'userToken';
  static String notification = 'notification';
  static String search = 'search';

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}
