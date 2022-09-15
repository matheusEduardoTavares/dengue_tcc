class ModulesRoute {
  ModulesRoute._();

  static const home = '/home';

  //SIGN
  static const signModule = '/sign';
  static const signModuleSignIN = '/signIN';
  static const signModuleSignUP = '/signUP';
  static const signModuleSignINNavigate = '$signModule/signIN';
  static const signModuleSignUPNavigate = '$signModule/signUP';
  //FORGOT PASSWORD
  static const forgotPasswordModule = '/forgotPassword';
  static const forgotPasswordModuleNavigate = '$signModule/forgotPassword';
  //TUTORIAL
  static const tutorialModule = '/tutorial';
  static const tutorialModuleNavigate = '$home/tutorial';
  //INFORMATION
  static const informationModule = '/information';
  static const informationModuleNavigate = '$home/information';
}
