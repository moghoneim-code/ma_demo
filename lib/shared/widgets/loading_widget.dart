import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// reusable [LoadingWidget] with default values
///
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SpinKitFadingCircle(
      color: Colors.grey,
      size: 50,
    );
  }
}
