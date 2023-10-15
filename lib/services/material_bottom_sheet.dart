import 'package:flutter/material.dart';
import 'package:ma_demo/modules/main_page/widgets/sample_ticket_widget.dart';
import 'package:provider/provider.dart';
import '../shared/providers/app_settings_provider.dart';

/// Bottom sheet widget to show ticket
@Deprecated('Use [SampleTicketWidget] instead')
class TicketBottomSheet extends StatelessWidget {
  const TicketBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.read<AppSettingProvider>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Container(
            width: 60,
            height: 10,
            decoration: BoxDecoration(
              color: p.isDarkMode ? Colors.white : Colors.black38,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            color: p.isDarkMode ? Colors.black : Colors.grey.withOpacity(0.1),
                child: const Center(
                    child: SampleTicketWidget(),
                )
          )),
        ],
      ),
    );
  }
}
