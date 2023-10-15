import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:ma_demo/constants/k_colors.dart';

class SwitchModeW extends StatefulWidget {
  const SwitchModeW({super.key});

  @override
  State<SwitchModeW> createState() => _SwitchModeWState();
}

class _SwitchModeWState extends State<SwitchModeW> {
  final _controller = ValueNotifier<bool>(false);

  /// get the current theme mode

  void _init() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      _controller.value = true;
    } else {
      _controller.value = false;
    }
  }

  @override
  void initState() {
    _init();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          AdaptiveTheme.of(context).setDark();
        } else {
          AdaptiveTheme.of(context).setLight();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/icons/Theme.svg',
          width: 40,
          height: 40,
          color: _controller.value ? Colors.white : KColors.mainColorLightMode,
        ),
      ),
      title: const Text(
        'Theme',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 1.5,
            color: _controller.value
                ? KColors.handleColorDarkMode
                : KColors.mainColorLightMode,
          ),
        ),
        child: AdvancedSwitch(
          controller: _controller,
          thumb: SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundColor:
                _controller.value ? KColors.handleColorDarkMode : KColors
                    .mainColorLightMode,
              ),
            ),
          ),
          activeColor: Colors.blueGrey.withOpacity(0.3),
          inactiveColor: Colors.grey.withOpacity(0.15),
          activeChild: Image.asset(
            'assets/images/sun.png',
            width: 60,
            height: 60,
          ),
          inactiveChild: Image.asset(
            'assets/images/moon.png',
            width: 40,
            height: 40,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          width: 100,
          height: 50,
          disabledOpacity: 0.5,

        ),
      ),
    );
  }
}
