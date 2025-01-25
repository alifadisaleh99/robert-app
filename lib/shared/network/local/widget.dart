
import 'package:robquiz/shared/network/local/cache_helper.dart';

class WidgetPublic {
  bool isLogInWidget() {
    if (CacheHelper.getData(key: 'token') != null &&
        CacheHelper.getData(key: 'token') != "") {
      return true;
    } else {
      return false;
    }
  }
}
