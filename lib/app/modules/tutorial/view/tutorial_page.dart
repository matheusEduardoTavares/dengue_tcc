import 'package:dengue_tcc/app/modules/tutorial/controller/tutorial_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/tutorial/controller/tutorial_controller_interface.dart';
import 'package:dengue_tcc/app/modules/tutorial/view/widgets/app_bar_dengue_image_widget.dart';
import 'package:dengue_tcc/app/modules/tutorial/view/widgets/tutorial_content_options/tutorial_alert_content_widget.dart';
import 'package:dengue_tcc/app/modules/tutorial/view/widgets/tutorial_content_options/tutorial_graphic_content_widget.dart';
import 'package:dengue_tcc/app/modules/tutorial/view/widgets/tutorial_content_options/tutorial_notification_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({
    required TutorialControllerInterface controller,
    Key? key,
  }) : 
  _controller = controller,
  super(key: key);

  final TutorialControllerInterface _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        elevation: 0,
        flexibleSpace: const AppBarDengueImageWidget(),
      ),
      body: SafeArea(
        child: BlocBuilder<Cubit<TutorialControllerState>, TutorialControllerState>(
          bloc: _controller,
          builder: (_, state) {
            return [
              TutorialAlertContentWidget(
                onTap: _controller.changePage,
                selectedBottomNavigatorBarIndex: state.selectedBottomNavigatorBarIndex,
              ),
              TutorialNotificationContentWidget(
                onTap: _controller.changePage,
                selectedBottomNavigatorBarIndex: state.selectedBottomNavigatorBarIndex,
              ),
              TutorialGraphicContentWidget(
                onTap: _controller.changePage,
                selectedBottomNavigatorBarIndex: state.selectedBottomNavigatorBarIndex,
              ),
            ][state.selectedBottomNavigatorBarIndex];
          }
        ),
      ),
    );
  }
}