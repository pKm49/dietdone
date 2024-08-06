import 'package:get/get_navigation/src/root/internacionalization.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar_AE": {
          "English": "عربي",
        },
        "en_US": {
          "English": "English",
          "create_new_password":"Create new password",
          "unique_password_msg":"Your new password must be unique from those previously used.",
          "new_password":"New Password",
          "please_enter_new_password":"Please enter your new password"
        }
      };
}
