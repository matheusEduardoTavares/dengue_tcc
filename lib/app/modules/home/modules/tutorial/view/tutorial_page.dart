import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/dengue_appbar.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/controller/tutorial_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/controller/tutorial_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/widgets/tutorial_content_options/tutorial_alert_content_widget.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/widgets/tutorial_content_options/tutorial_graphic_content_widget.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/view/widgets/tutorial_content_options/tutorial_notification_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({
    required TutorialControllerInterface controller,
    this.initialIndex,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final TutorialControllerInterface _controller;
  final int? initialIndex;

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  void initState() {
    super.initState();

    if (widget.initialIndex != null) {
      widget._controller.changePage(widget.initialIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DengueAppbar(),
      body: SafeArea(
        child: BlocBuilder<Cubit<TutorialControllerState>,
                TutorialControllerState>(
            bloc: widget._controller,
            builder: (_, state) {
              return [
                TutorialAlertContentWidget(
                  onTap: widget._controller.changePage,
                  selectedBottomNavigatorBarIndex:
                      state.selectedBottomNavigatorBarIndex,
                ),
                TutorialNotificationContentWidget(
                  onTap: widget._controller.changePage,
                  selectedBottomNavigatorBarIndex:
                      state.selectedBottomNavigatorBarIndex,
                ),
                TutorialGraphicContentWidget(
                  onTap: widget._controller.changePage,
                  selectedBottomNavigatorBarIndex:
                      state.selectedBottomNavigatorBarIndex,
                ),
              ][state.selectedBottomNavigatorBarIndex];
            }),
      ),
    );
  }
}
