import 'package:dengue_tcc/app/modules/sign/view/widgets/sign_background/sign_background.dart';
import 'package:flutter/material.dart';

class DefaultPageWithScrollWidget extends StatelessWidget {
  const DefaultPageWithScrollWidget({
    required this.child,
    this.formKey,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    final content = SignBackground(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: child,
          ),
        ],
      ),
    );

    return Scaffold(
      body: formKey != null
          ? Form(
              key: formKey,
              child: content,
            )
          : content,
    );
  }
}
