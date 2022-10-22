part of 'add_next_campaing_controller_cubit.dart';

class AddNextCampaingControllerState {}

class LoadingAddNextCampaingControllerState
    extends AddNextCampaingControllerState {}

class ErrorAddNextCampaingControllerState
    extends AddNextCampaingControllerState {
  ErrorAddNextCampaingControllerState({
    required this.errorMessage,
  });

  final String errorMessage;
}

class SuccessAddNextCampaingControllerState
    extends AddNextCampaingControllerState {
  SuccessAddNextCampaingControllerState({
    required this.model,
  });

  final NextCampaignModel model;
}
