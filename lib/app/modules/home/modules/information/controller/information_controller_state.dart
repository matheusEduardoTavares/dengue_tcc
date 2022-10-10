part of 'information_controller_cubit.dart';

class InformationControllerState {
  InformationControllerState({
    this.pageType = InformationEnum.nextCampaigns,
  });
  final InformationEnum pageType;

  InformationControllerState copyWith({
    InformationEnum? pageType,
  }) {
    return InformationControllerState(
      pageType: pageType ?? this.pageType,
    );
  }
}

class LoadingInformationControllerState extends InformationControllerState {
  LoadingInformationControllerState({
    super.pageType,
  });
}

class ErrorInformationControllerState extends InformationControllerState {
  ErrorInformationControllerState({
    required this.errorMessage,
    super.pageType,
  });

  final String errorMessage;
}

class SuccessInformationControllerState extends InformationControllerState {
  SuccessInformationControllerState({
    required this.model,
    super.pageType,
  });

  final InformationsModel model;
}
