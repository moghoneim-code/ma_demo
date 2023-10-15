import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ma_demo/modules/main_page/widgets/sample_ticket_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  testWidgets('showCupertinoBottomSheet displays bottom sheet',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        child: const SampleTicketWidget()));
              },
              child: const Text('Show Bottom Sheet'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Bottom Sheet'));
    await tester.pumpAndSettle();
    expect(find.byType(SampleTicketWidget), findsOneWidget);

  });
}
