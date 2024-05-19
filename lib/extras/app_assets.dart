class AppImages {
  static var main = "assets/images/";
  static var logo = getName("logo.png");
  static var background = getName("background.png");
  static var gradientBackground = getName("gradientBackground.png");
  static var streak = getName("streak.png");

  static String getName(String name) {
    return "$main$name";
  }
}

class AppIcons {
  static var main = "assets/icons/";
  static var google = getName("google.png");
  static var showPassword = getName("show.png");
  static var mic = getName("mic.png");
  static var playing = getName("playing.png");
  static var home = getName("home.png");
  static var practise = getName("practise.png");
  static var review = getName("review.png");
  static var challenge = getName("challenge.png");
  static var apple1 = getName("apple1.png");
  static var delete = getName("delete.png");
  static var restart = getName("restart.png");

  static String getName(String name) {
    return "$main$name";
  }
}
