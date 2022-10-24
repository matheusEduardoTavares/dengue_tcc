import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';
import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaigns_model.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:dengue_tcc/app/utils/extensions/datetime_extension.dart';
import 'package:dengue_tcc/app/utils/webview_control/webview_control.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InformationItemWidget extends StatelessWidget {
  const InformationItemWidget({
    required this.model,
    super.key,
  });

  final InformationModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          AppShadows.informationItemShadow,
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[400],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            model.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            model.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            model.date.getFormattedDate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          if (model is NextCampaignModel &&
              (model as NextCampaignModel).url != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: RichText(
                text: TextSpan(
                  text: 'Acessar: ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          WebviewControl.openWebviewLink(
                            context: context,
                            linkToOpen: (model as NextCampaignModel).url!,
                          );
                        },
                      text: (model as NextCampaignModel).url!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
