import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:ma_demo/shared/widgets/app_elevated_button.dart';
import 'package:ma_demo/shared/widgets/app_outlined_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../services/bottom_sheet_service.dart';
import '../../../shared/providers/app_settings_provider.dart';
import '../../reservation/screens/reservation_screen.dart';
import '../widgets/sample_ticket_widget.dart';
import '../widgets/switch_mode_widget.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({
    super.key,
  });

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      AdaptiveTheme.of(context).modeChangeNotifier.addListener(() {
        context.read<AppSettingProvider>().isDarkMode =
            AdaptiveTheme.of(context).modeChangeNotifier.value ==
                AdaptiveThemeMode.dark;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              /// Switch Mode Widget is used to switch between dark and light mode
              const SwitchModeW(),

              /// Spacer is used to add space between top and bottom widgets
              const Spacer(),

              /// Buttons to show the bottom sheets for IOS , Android And Dart Bottom Sheet
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: AppElevatedButton(
                    height: 70,
                    title: 'Open Reservation',

                    /// This method is used to show the cupertino bottom sheet in Dart
                    /// [ReservationScreen] is the screen that will be shown in the bottom sheet
                    onPressed: () => showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: const ReservationScreen()))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: AppOutlinedButton(
                    height: 70,
                    title: 'Show IOS Ticket',
                    onPressed: () =>
                        BottomSheetService.showFlutterBottomSheet()),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextButton(
                      onPressed: () {
                        /// This method is used to show the android bottom sheet in Dart
                        BottomSheetService.showFlutterBottomSheet();
                        showCupertinoBottomSheet();
                      },
                      child: const Text(
                        'Show Android Ticket',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  /// This method is used to show the cupertino bottom sheet in Dart
  void showCupertinoBottomSheet() async {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: const SampleTicketWidget()));
  }
}
