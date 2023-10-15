// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ma_demo/constants/k_colors.dart';
import 'package:ma_demo/shared/providers/app_settings_provider.dart';
import 'package:ma_demo/shared/widgets/dashed_divider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../../main_page/widgets/ticket_widget.dart';
import '../models/reservation_model.dart';
import 'images_gallery.dart';

class HotelInfo extends StatefulWidget {
  final List<Stay> stays;
  final List<UserTicket> tickets;
  final DateTime startDate;
  final DateTime endDate;

  const HotelInfo(
      {super.key,
      required this.stays,
      required this.tickets,
      required this.startDate,
      required this.endDate});

  @override
  State<HotelInfo> createState() => _HotelInfoState();
}

class _HotelInfoState extends State<HotelInfo> {
  final List<String> _avatarImages = [];

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < widget.tickets.length; i++) {
      _avatarImages.add(widget.tickets[i].ticketUserData!.avatar!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AppSettingProvider>();
    final theme = Theme.of(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.stays.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final isLast = index == widget.stays.length - 1;
          return Theme(
            data: theme.copyWith(
              dividerColor: Colors.transparent,
            ),
            child: Card(
              shadowColor: Colors.transparent,
              elevation: 0,
              color: theme.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  maintainState: true,
                  iconColor: p.isDarkMode ? Colors.white : Colors.black,
                  collapsedIconColor:
                      p.isDarkMode ? Colors.white : Colors.black,
                  initiallyExpanded: !isLast,
                  trailing: _buildTrailingAvatars(_avatarImages),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    widget.stays[index].name!,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [
                    _buildOrdinaryDivider(),
                    _buildGuestsPart(widget.stays[index].rooms!),
                    const SizedBox(
                      height: 12,
                    ),
                    _displayDataPart(
                      from: _formatDate(widget.startDate),
                      to: _formatDate(widget.endDate),
                      stars: widget.stays[index].stars!,
                      roomCount: widget.stays[index].rooms!.length.toString(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildLocationPart(widget.stays[index]),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTickets(),
                    const SizedBox(
                      height: 16,
                    ),
                    const DashedDDivider(),
                    const SizedBox(
                      height: 16,
                    ),
                    _roomsWidget(widget.stays[index].rooms!),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildGallery(widget.stays[index]),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildAmenities(widget.stays[index].amenities!),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildGallery(Stay stay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Gallery : ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ImagesGallery(images: stay.stayImages!),
      ],
    );
  }

  Widget _buildOrdinaryDivider() {
    final p = context.watch<AppSettingProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: p.isDarkMode ? Colors.white : Colors.grey,
      ),
    );
  }

  Widget _roomsWidget(List<Room> rooms) {
    return ListView.builder(
      itemBuilder: (context, index) => _room(index: index, room: rooms[index]),
      itemCount: rooms.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _room({required int index, required Room room}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Reservation ${index + 1}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          _buildGuestsPart([room]),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDateDisplay('Room Type', room.roomTypeName!),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateDisplay('Room Number', room.roomNumber.toString()),
                _buildDateDisplay('Sleeps', room.roomCapacity.toString()),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const DashedDDivider(),
        ],
      ),
    );
  }

  Widget _displayDataPart(
      {required String from,
      required String to,
      required int stars,
      required String roomCount}) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 32,
          ),
          children: [
            _buildDateDisplay('From', from),
            _buildDateDisplay('Till', to),
            _buildStars(
              stars,
            ),
            _buildDateDisplay('Room Count', roomCount),
          ],
        ),
      ),
    );
  }

  Widget _buildDateDisplay(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(subtitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                )),
      ],
    );
  }

  Widget _buildStars(int stars) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stars',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            for (var i = 0; i < stars; i++)
              const Icon(
                Icons.star,
                color: Color(0xffFFD979),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildGuestsPart(List<Room> rooms) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Guests : ',
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(
            height: 12,
          ),
          for (var i = 0; i < rooms.length; i++)
            for (var j = 0; j < rooms[i].guests!.length; j++)
              ListTile(
                  title: Text(
                    '${rooms[i].guests![j].firstName!} ${rooms[i].guests![j].lastName!}',
                    style: theme.textTheme.displaySmall,
                  ),
                  leading: _buildCircularAvatar(rooms[i].guests![j].avatar!)),
        ],
      ),
    );
  }

  Widget _buildTrailingAvatars(List<String> images) {
    return SizedBox(
        width: 100,
        child: Stack(
          children: [
            for (var i = 0; i < images.length; i++)
              Positioned(
                left: i * 15.0,
                child: _buildCircularAvatar(images[i]),
              ),
          ],
        ));
  }

  Widget _buildCircularAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
    );
  }

  Widget _buildLocationPart(Stay stay) {
    final p = context.watch<AppSettingProvider>();
    return InkWell(
      onTap: () async {
        await url_launcher.launch(
            'https://www.google.com/maps/search/?api=1&query=${stay.lat},${stay.lng}');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            color: p.isDarkMode ? Colors.black : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: KColors.iconThemeColor.withOpacity(0.45),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AutoSizeText(stay.name!,
                                maxFontSize: 24,
                                minFontSize: 20,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AutoSizeText(stay.address!,
                                maxFontSize: 18,
                                minFontSize: 18,
                                style: Theme.of(context).textTheme.bodyMedium!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/map.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.075,
                          left: MediaQuery.of(context).size.width * 0.15,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }

  Widget _buildTickets() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Text(
          'Tickets',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
        ),
        ...widget.tickets.map((e) => TicketWidget(ticket: e)),
      ],
    );
  }

  Widget _buildAmenities(String amenities) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Amenities',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              amenities,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
