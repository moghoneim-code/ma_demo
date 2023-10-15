import 'package:auto_size_text/auto_size_text.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:ma_demo/constants/k_colors.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/app_settings_provider.dart';


class SampleTicketWidget extends StatelessWidget {
  const SampleTicketWidget({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final p = context.read<AppSettingProvider>();
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CouponCard(
          height: MediaQuery.of(context).size.height * 0.25,
          curvePosition: MediaQuery.of(context).size.height * 0.1 ,
          curveRadius: 30,
          borderRadius: 10,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4) ,
          ),
          firstChild: Center(
            child: SizedBox(
              height: 50,
              child: ListTile(
                leading: const Image(
                  image: AssetImage('assets/images/avatar.png'),
                  width: 75,
                  height: 75,
                ),
                subtitle: AutoSizeText(
                  '#170122708123',
                  maxLines: 1,
                  maxFontSize: 18,
                  minFontSize: 14,
                  style: TextStyle(
                    color: p.isDarkMode ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: AutoSizeText(
                    'Marilyn Bridges James',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 22,
                    minFontSize: 20,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          secondChild: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AutoSizeText(
                      'Ticket Details : ',
                      maxLines: 1,
                      maxFontSize: 18,
                      minFontSize: 14,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: p.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        'MATCH Business Seat',
                        maxLines: 2,
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: p.isDarkMode ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Seat  : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: p.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        'Block 112 Row S Seat 1',
                        maxLines: 2,
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: p.isDarkMode ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
