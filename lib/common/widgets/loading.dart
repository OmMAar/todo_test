import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:morphosis_flutter_demo/common/widgets/widget_helper.dart';
import 'package:morphosis_flutter_demo/constants/app_styles.dart';
import 'package:morphosis_flutter_demo/constants/assets.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/utils/locale/app_localization.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: WidgetHelper.buildGradient(
              firstColor: AppColors.primaryColor,
              secondColor: AppColors.secondaryColor,
              thirdColor: AppColors.lightSecondaryColor)),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(Assets.loading_animated),
              SizedBox(
                height: 8,
              ),
              Text(
                AppLocalizations.of(context).translate('loading'),
                style:
                    AppStyles.text14Style.copyWith(color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
