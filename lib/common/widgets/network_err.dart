import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/app_styles.dart';
import 'package:morphosis_flutter_demo/constants/assets.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/utils/locale/app_localization.dart';

class NetworkError extends StatelessWidget {
  final VoidCallback onPressed;

  const NetworkError({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.connectionError,
                width: 240,
                height: 240,
              ),
              Text(
                AppLocalizations.of(context).translate('connection_err'),
                style: AppStyles.text14Style,
                textAlign: TextAlign.center,
              ),
              FlatButton(
                onPressed: onPressed,
                child: Text(
                  AppLocalizations.of(context).translate('retry'),
                  style: AppStyles.text14Style
                      .copyWith(color: AppColors.whiteColor),
                ),
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
