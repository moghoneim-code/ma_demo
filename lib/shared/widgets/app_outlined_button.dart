import 'package:flutter/material.dart';
import 'package:ma_demo/constants/k_colors.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';
import 'loading_widget.dart';

/// Outlined button with custom style and loading widget when [isLoading] is true
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    Key? key,
    required this.title,
    this.isLoading = false,
    this.isEnabled = true,
    required this.onPressed,
    this.fontSize,
    this.height,
  }) : super(key: key);

  final String title;
  final bool isLoading;
  final bool isEnabled;
  final double? height;
  final double? fontSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 45,
      child: _buildButtonBody(context),
    );
  }

  Widget _buildButtonBody(BuildContext context) {
    final p = context.read<AppSettingProvider>();
    if (isLoading) return const Center(child: LoadingWidget());
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        foregroundColor: KColors.mainColorLightMode,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),

        /// side
        side: BorderSide(
          color: p.isDarkMode
              ? KColors.mainColorDarkMode
              : KColors.mainColorLightMode,
          width: 2,
        ),
      ),
      child: Text(title,
          style: TextStyle(
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.bold,
            color: p.isDarkMode
                ? KColors.mainColorDarkMode
                : KColors.mainColorLightMode,
          )),
    );
  }
}
