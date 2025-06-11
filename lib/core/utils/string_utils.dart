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

  static String getGenderTitle(int genderType) {
    return switch (genderType) {
      GenderTypes.male => language.men,
      GenderTypes.female => language.women,
      GenderTypes.kids => language.kids,
      _ => language.all,
    };
  }
}
