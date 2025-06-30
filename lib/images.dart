import 'dart:math';

class Images {
  /// Avatars ///
  static List<String> avatars = List.generate(10, (index) => 'assets/images/avatar/avatar_${index + 1}.png');

  static List<String> dummy = List.generate(5, (index) => 'assets/images/dummy/dummy_${index + 1}.jpg');

  static String auth = 'assets/images/dummy/auth.png';
  static String logoLight = 'assets/images/logo/logo_light.png';
  static String logoDark = 'assets/images/logo/logo_dark.png';


  static String randomImage(List<String> images) => images[Random().nextInt(images.length)];
}
