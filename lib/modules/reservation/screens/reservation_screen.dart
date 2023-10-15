import 'package:flutter/material.dart';
import 'package:ma_demo/Network/view_state.dart';
import 'package:ma_demo/shared/providers/app_settings_provider.dart';
import 'package:ma_demo/shared/widgets/error_loading_widget.dart';
import 'package:ma_demo/shared/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/k_network.dart';
import '../models/reservation_model.dart';
import '../providers/reservation_provider.dart';
import '../widgets/hotel_info_widget.dart';
import '../widgets/main_image_widget.dart';

/// Reservation screen to show the reservation details
///  we use the First reservation in the list of reservations only => just to show the UI
class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  void initState() {
    /// fetch the data from the API and cache it in the database
    ///
    Future.delayed(Duration.zero).then((_) =>
        context.read<ReservationProvider>().fetchData(KNetwork.dataPath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// [AppSettingProvider] to get the dark mode value
    final darkMode = context.watch<AppSettingProvider>().isDarkMode;

    /// use of [Consumer] to listen to the changes in the [ReservationProvider]
    /// and rebuild the UI
    ///
    return Consumer<ReservationProvider>(builder: (context, p, _) {
      return Scaffold(
          backgroundColor: darkMode ? Colors.black : Colors.white,
          appBar: PreferredSize(

              /// PreferredSize is used to set the height of the app bar
              ///
              preferredSize: const Size.fromHeight(30),

              /// [buildAppBar] is a function to build the app bar
              child: buildAppBar(context)),

          /// [buildBody] is a function to build the body of the screen
          body: _buildBody());
    });
  }

  /// [buildBody] is a function to build the body of the screen
  Widget _buildBody() {
    return Consumer<ReservationProvider>(builder: (context, p, _) {
      /// [ViewState] is used to show the loading widget or the error widget
      if (p.viewState == ViewState.loading) {
        return const Center(
          child: LoadingWidget(),
        );
      }

      /// [ViewState] is used to show the loaded reservation
      if (p.viewState == ViewState.loaded) {
        return _buildReservationWidget(p.reservations.first);
      }

      if (p.viewState == ViewState.error) {
        /// [ErrorLoadingWidget] is used to show there is an error and provide a way to reload
        return ErrorLoadingWidget(
          onTryAgain: () {
            p.fetchData(KNetwork.dataPath);
          },
        );
      }
      return const SizedBox();
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      shadowColor: Colors.black,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Container(
        height: 10,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[100],
        ),
      ),
    );
  }

  /// [buildReservationWidget] is a function to build the reservation Ui
  Widget _buildReservationWidget(Reservation reservation) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        MainImageWidget(imageUrl: reservation.stays!.first.stayImages!.first),
        const SizedBox(
          height: 24,
        ),
        ListTile(
          title: Text(
            'Hotel Check-In',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Multible Reservations',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),

        /// [HotelInfo] is a widget to show the hotel info in the reservation screen
        HotelInfo(
          stays: reservation.stays!,
          tickets: reservation.userTickets!,
          startDate: reservation.startDate!,
          endDate: reservation.endDate!,
        ),
      ],
    );
  }
}
