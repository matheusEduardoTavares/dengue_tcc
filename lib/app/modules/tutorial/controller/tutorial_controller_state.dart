part of 'tutorial_controller_cubit.dart';

class TutorialControllerState {
  const TutorialControllerState({
    required this.selectedBottomNavigatorBarIndex,
  });

  factory TutorialControllerState.initial() => const TutorialControllerState(
    selectedBottomNavigatorBarIndex: 0,
  );

  final int selectedBottomNavigatorBarIndex;  

  TutorialControllerState copyWith({
    int? selectedBottomNavigatorBarIndex,
  }) {
    return TutorialControllerState(
      selectedBottomNavigatorBarIndex: selectedBottomNavigatorBarIndex ?? this.selectedBottomNavigatorBarIndex,
    );
  }
}
