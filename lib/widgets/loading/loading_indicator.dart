import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/theme/app_theme.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(140.0),
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [AppColors.blue400],
          strokeWidth: 3,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
