import '../../main.dart';
import '../constants/app_constants.dart';

class StringUtils {
  static String getAddressTitle(int addressType) {
    return switch (addressType) {
      AddressTypes.home => language.home,
      AddressTypes.work => language.work,
      AddressTypes.family => language.familyOrFriend,
      _ => language.other,
    };
  }

  static String getGenderTitle({bool isForMale = false, bool isForFemale = false, bool isForKids = false}) {
    if (isForMale && isForFemale && isForKids) {
      return language.all;
    } else if (isForMale) {
      return language.men;
    } else if (isForFemale) {
      return language.women;
    } else {
      return language.kids;
    }
  }
}
