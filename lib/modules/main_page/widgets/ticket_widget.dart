import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/app_settings_provider.dart';
import '../../reservation/models/reservation_model.dart';

class TicketWidget extends StatelessWidget {
  final UserTicket? ticket;

  const TicketWidget({Key? key, this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = context.read<AppSettingProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CouponCard(
        height: MediaQuery.of(context).size.height * 0.23,
        curvePosition: MediaQuery.of(context).size.height * 0.1,
        curveRadius: 30,
        borderRadius: 10,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
        ),
        firstChild: Center(
          child: SizedBox(
            height: 50,
            child: ListTile(
              leading: CachedNetworkImage(
                  imageUrl: ticket!.ticketUserData!.avatar!,
                  width: 75,
                  height: 75,
                  imageBuilder: (context, imageProvider) => Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
              subtitle: AutoSizeText(
                ticket!.ticketSystemId!,
                maxLines: 1,
                maxFontSize: 18,
                minFontSize: 14,
                style: TextStyle(
                  color: p.isDarkMode ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(
                  bottom: 8,
                ),
                child: AutoSizeText(
                  '${ticket!.ticketUserData!.firstName} ${ticket!.ticketUserData!.lastName}',
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
                    'Ticket Details :',
                    maxLines: 1,
                    maxFontSize: 16,
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
                      ticket!.ticketTypeName!,
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
                      'Gate ${ticket!.gate!} Seat ${ticket!.seat!}',
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
    );
  }
}
