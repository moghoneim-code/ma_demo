import 'package:flutter/material.dart';
import 'loading_widget.dart';

/// reusable [ElevatedButton] with loading state widget and disabled state

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
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
    if (isLoading) return const Center(child: LoadingWidget());
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        title,
      ),
    );
  }
}
