import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:ma_demo/Network/dio_config.dart';
import 'package:ma_demo/Network/view_state.dart';
import 'package:ma_demo/constants/k_network.dart';
import 'package:ma_demo/services/sqflite_service/cached_api_databse.dart';

import '../models/reservation_model.dart';

class ReservationProvider extends ChangeNotifier {
  /// [ViewState] instance to handle the state of the view
  ViewState _viewState = ViewState.initial;

  /// getter for the view state
  ViewState get viewState => _viewState;

  /// [List] of [Reservation] to hold the reservations data
  List<Reservation> _reservations = [];

  /// getter for the reservations list
  List<Reservation> get reservations => _reservations;

  /// [fetchAndCacheData] function to fetch the data from the API and cache it
  /// in the database
  ///  - [urlPath] is the path of the API endpoint
  ///  - [dioClientWithRefreshToken] is a function to get the data from the API
  Future<void> fetchAndCacheData(String urlPath) async {
    try {
      /// get the data from the API using the [dioClientWithRefreshToken] function
      final response =
          await dioClientWithRefreshToken(KNetwork.baseURL).get(urlPath);

      /// cache the response data
      /// - [urlPath] is the path of the API endpoint
      /// - [response.data] is the response data
      ///  - [response.data] is a [Map] object
      ///  - [jsonEncode] is a function to convert the [Map] object to a [String]
      await CachedApiDatabase.instance.cacheResponse(urlPath, response.data);
      log("API Response: ${response.data}");

      /// set the reservations data
      /// - [response.data] is a [Map] object
      /// - [jsonEncode] is a function to convert the [Map] object to a [String]
      await setReservationsData(response.data);
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> setReservationsData(var data) async {
    /// clear the reservations list
    _reservations.clear();

    /// get the reservations data from the response
    /// - [data] is a [Map] object
    /// - [data['reservations']] is a [List] of [Map] objects
    final reservations = data['reservations'];
    for (var reservation in reservations) {
      /// - [Reservation.fromJson] is a function to convert the [Map] object to a [Reservation] object
      /// - [reservation] is a [Map] object
      /// - [Reservation.fromJson] returns a [Reservation] object
      _reservations.add(Reservation.fromJson(reservation));
    }
    _viewState = ViewState.loaded;
    return;
  }

  Future<void> fetchData(String urlPath) async {
    _viewState = ViewState.loading;
    notifyListeners();
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        log('No internet connection. Retrieving cached data.');
        dynamic cachedData =
            await CachedApiDatabase.instance.getCachedData(urlPath);
        if (cachedData != null) {
          /// here we can use the cached data
          await setReservationsData(cachedData);
        } else {
          /// no cached data found or error in retrieving cached data [whether it's null or not]
          _viewState = ViewState.error;
          log("No cached data found.");
        }
      } else {
        /// there is internet connection
        /// fetch the data from the API and cache it
        await fetchAndCacheData(urlPath);
      }
    } catch (e) {
      /// error in retrieving cached data
      /// or error in fetching data from the API
      _viewState = ViewState.error;
      log("Error: $e");
    } finally {
      /// notify the listeners to rebuild the UI
      notifyListeners();
    }
  }

  /// [setReservations] function to set the reservations list
  /// - [value] is the new value of the reservations list
  set reservations(List<Reservation> value) {
    _reservations = value;
    notifyListeners();
  }

  /// [setViewState] function to set the view state
  /// - [value] is the new value of the view state
  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }
}
