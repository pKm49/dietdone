import 'package:get/get_navigation/src/root/internacionalization.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar_AE": {
          "English": "عربي",
          "notification_access_permission_title": "Enable notifications",
          "notification_access_permission_info": "To share important updates and exciting news! please grant Lifebalance permission to send notifications.",

        },
        "en_US": {
          "English": "English",
          "notification_access_permission_title": "تمكين الإخطارات",
          "notification_access_permission_info": "لمشاركة التحديثات الهامة والأخبار المثيرة! يرجى منح Lifebalance الإذن لإرسال الإشعارات.",

        }
      };
}
