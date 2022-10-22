class ModulesRoute {
  ModulesRoute._();

  static const home = '/home';
  static const homeMapMarker = '/mapMarker';
  static const homeMapMarkerNavigate = '$home/mapMarker';

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
  //ADD NEXT CAMPAIGN
  static const addNextCampaignModule = '/addNextCampaign';
  static const addNextCampaignModuleNavigate =
      '$informationModuleNavigate/addNextCampaign';
  //MARKERS LIST
  static const markersListModule = '/markersList';
  static const markersListModuleNavigate = '$home/markersList';
}
