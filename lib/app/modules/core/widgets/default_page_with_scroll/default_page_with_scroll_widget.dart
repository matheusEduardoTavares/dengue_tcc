import 'package:dengue_tcc/app/modules/sign/view/widgets/sign_background/sign_background.dart';
import 'package:flutter/material.dart';

class DefaultPageWithScrollWidget extends StatelessWidget {
  const DefaultPageWithScrollWidget({
    required this.child,
    this.formKey,
    this.hasScrollBody = false,
    this.appBar,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final GlobalKey<FormState>? formKey;
  final bool hasScrollBody;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final content = SignBackground(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
          ),
          SliverFillRemaining(
            hasScrollBody: hasScrollBody,
            child: child,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: formKey != null
          ? Form(
              key: formKey,
              child: content,
            )
          : content,
    );
  }
}
