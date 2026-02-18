sealed class PConstants {
  PConstants._();

  static const font = "Inter";
  static const baseUrl = "http://45.147.196.213:8080";
  static const playStore = "";
  // static const appStore = "https://apps.apple.com/app/telegram-messenger/id686449807";
}

sealed class PIcons {
  PIcons._();

  static const homeIcon = "assets/icons/home_search.svg";
  static const profileIcon = "assets/icons/profile.svg";
  static const messageIcon = "assets/icons/sell.svg";
  static const sellIcon = "assets/icons/messages.svg";
  static const mainLogo = "assets/icons/main_logo.svg";
  static const mainLogoText = "assets/icons/logo_text.svg";
  static const languageIcon = "assets/images/language.png";
  static const uzIcon = "assets/icons/uz.svg";
  static const ruIcon = "assets/icons/ru.svg";
  static const discountIcon = "assets/icons/hot-price.svg";
  static const favouriteIcon = 'assets/icons/favourite.svg';
  static const locationIcon = 'assets/icons/location_on.svg';
  static const editInfoIcon = 'assets/icons/edit_info.svg';
  static const supportIcon = "assets/icons/customer-support.svg";
  static const infoIcon = "assets/icons/information-square.svg";
  static const myAnnoucementscon = "assets/icons/my_announcements.svg";
  static const userProfileIcon = "assets/icons/user_profile.svg";
  static const themeIcon = "assets/icons/theme.svg";
  static const languageSquareIcon = "assets/icons/language-square.svg";
  static const arrowRightIcon = "assets/icons/arrow-right.svg";
  static const favouriteProfileIcon = 'assets/icons/favourite_profile.svg';
  static const lighthemeImg = "assets/images/light_theme.png";
  static const darkThemeImg = "assets/images/dark_theme.png";
  static const supportImg = "assets/images/support.png";
  static const platformInfoImg = "assets/images/platform_info.png";
  static const profileUnAuth = "assets/icons/profile_unauth.svg";
  static const choseLangImg = "assets/images/choose_lan.png";
  static const infoImg = 'assets/images/info.png';
  static const likedImg = "assets/images/liked.png";
  static const salesImg = "assets/images/sales.png";
  static const callIcon = "assets/icons/call.svg";
  static const deleteIcon = "assets/icons/delete.svg";
  static const fileVideIcon = "assets/icons/file-video.svg";
  static const imageAddIcon = "assets/icons/image-add-01.svg";
  static const reportIcon = "assets/icons/report.svg";
  static const sendIcon = "assets/icons/send.svg";
  static const threeDots = "assets/icons/three_dots.svg";
  static const userSquare = "assets/icons/user-square.svg";
  static const arrowLeftIcon = "assets/icons/arrow-left.svg";
  static const doubleTickICon = "assets/icons/tick-double.svg";
  static const tickIcon = "assets/icons/tick-01.svg";
  static const deleteTextIcon = "assets/icons/delete_text.svg";
  static const filtersIcon = "assets/icons/filter-horizontal.svg";
  static const menuIcon = "assets/icons/menu-11.svg";
  static const arrorDown = "assets/icons/arrow-down-03-round.svg";
  static const searchIcon = "assets/icons/search.svg";
  static const cancelIcon = "assets/icons/cancel-01.svg";
  static const menu2Icon = "assets/icons/menu-02.svg";
  static const viewIcon = "assets/icons/view.svg";
  static const addring = "assets/icons/add-ring.svg";
  static const location5Icon = "assets/icons/location-05.svg";
  static const checkinImg = "assets/images/checking_item.png";
  static const wantFastImg = "assets/images/want_fast.png";
  static const logOutIcon = "assets/icons/logout-01.svg";
  static const deleteImgIcon = "assets/icons/delete_img.svg";
  static const selectedIcon = "assets/icons/selected.svg";
}

sealed class PKeys {
  PKeys._();

  static const String box = "sapi";
  static const String onboarded = 'onboarded';
  static const String accessToken = "access_token";
  static const String refreshToken = "refresh_token";
  static const String userId = "user_id";
  static const String loggedIn = "logged_in";
  static const String firstname = "firstname";
  static const String lastname = "lastname";
  static const String phone = "phone";
  static const String password = "password";
  static const String avatar = "avatar";
  static const String locale = "locale";
  static const String themeMode = "theme_mode";
  static const String isCreator = 'is_creator';
  static const String showLottie = 'showLottie';
  static const String fcmToken = 'fcm_token';
  static const String imageUrl = 'image_url';
  static const String selectedImgIndex = 'selected_img_index';
}

sealed class PUrls {
  PUrls._();

  // app
  static const String fetchUser = '/user/get-me/';

  // auth
  static const String refress = '/api/token/refresh/';
  static const String login = "/api/register/";
  static const String confirmOtp = '/api/verifay/';
  static const String getUser = "/api/get-user/";
  static const String editUser = "/api/user-update/";
  static const String createProduct = "/api/product/product/";
  static const String uploadFile = '/files/create/';
  static const String registerFmc = '/api/fcm/register-device/';
  static const String postProfuct = '/api/product/product/';
  static const String getCategories = '/api/product/get-category/';
  static const String getRegions = '/api/product/get-region/';
  static const String getMyProducts = '/api/product/product/my_product/';
  static const String likeProduct = '/api/product/like/';
  static const String getLikedItems = '/api/product/like/';
  static const String getWatchingItems = '/api/product/pricewatch/';
  static const String postWatchItem = '/api/product/pricewatch/';
  static const String getBanners = '/api/banners/';
  static const String getProduct = 'api/product/product/';
  static const String getSearchProducts = '/api/product/product/search/';
  static const String createRoom = "/api/chat/chat-crete/";
  static const String getChatList = "/api/chat/chat-list/";
  static String sendMessage(int id) => "api/chat/message-create/$id/";
  static String getChatMessages(int id) => "api/chat/message-list/$id/";
  static String deleteChat(int id) => '/api/chat/chat-delete/$id/';
  static String deleteWatchItem(int id) => '/api/product/pricewatch/$id/';
  static String deleteProduct(int id) => 'api/product/like/$id/';
  static String editProduct(int id) => '/api/product/product/$id/';
  static String getSubCategories(int id) => '/api/product/get-sub-category/$id/';
}
