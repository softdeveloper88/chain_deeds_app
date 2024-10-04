class Constants {
  // Base URLs
  static const String baseApiUrl = 'https://chainofdeeds.com/api/v1/';
  static const String baseImageUrl = 'https://chainofdeeds.com/';

  // API Endpoints
  static const String getUserEndpoint = 'user/get';
  static const String postLoginEndpoint = 'user/login';

  // Default Values
  static const int defaultPageSize = 20;
  static const String defaultUserAvatar = 'default_avatar.png';

  // Error Messages
  static const String networkError = 'Network error, please try again.';
  static const String serverError = 'Server error, please try again later.';

  static var userToken='';

  static var logInUserId='';

  static var name='';

  static var profile_pic='';

  static var email='';

  static var deviceToken='';

  static String phone='';

}
