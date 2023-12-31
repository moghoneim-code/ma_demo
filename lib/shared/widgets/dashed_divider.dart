import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

/// reusable [DottedLine] widget with default values
class DashedDDivider extends StatelessWidget {
  const DashedDDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Colors.grey,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}
