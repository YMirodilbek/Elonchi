part of "app_routes.dart";

sealed class Routes {
  Routes._();

  static const String splashScreen = '/splash_page';
  static const String home = '/home_page';
  static const String race = '/sell_page';
  static const String profile = '/profile';
  static const String messages = '/messages';
  static const String languageScreen = "/language_page";
  static const String conversationScreen = '/conversation_page';
  static const String myWishes = "/my_wishes_page";
  static const String salesScreen = '/sales_page';
  static const String singleItemScreen = "/single_item_page";
  static const String searchScreen = "/search_page";
  static const String filtersScreen = "/filters_page";
  static const String categoriesScreen = "/categories_page";
  static const String addItemScreen = "/add_item_page";
  static const String authScreen = '/auth_page';
  static const String otpConfirmScreen = '/otp_confirm_page';
  static const String editProfileScreen = '/edit_profile_page';
  static const String successItemAddedScreen = '/success_item_added_page';
  static const String editItemScreen = "/edit_item_page";
}
