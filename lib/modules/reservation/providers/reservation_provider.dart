import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:ma_demo/Network/dio_config.dart';
import 'package:ma_demo/Network/view_state.dart';
import 'package:ma_demo/constants/k_network.dart';
import 'package:ma_demo/services/sqflite_service/cached_api_databse.dart';

import '../models/reservation_model.dart';

class ReservationProvider extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;
  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  Future<void> fetchAndCacheData(String urlPath) async {
    try {
      final response =
          await dioClientWithRefreshToken(KNetwork.baseURL).get(urlPath);
      await CachedApiDatabase.instance.cacheResponse(urlPath, response.data);
      log("API Response: ${response.data}");
      await setReservationsData(response.data);
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> setReservationsData(var data) async {
    final reservations = data['reservations'];
    for (var reservation in reservations) {
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
          log(cachedData.toString());
          await setReservationsData(cachedData);
        } else {
          /// no cached data found
          _viewState = ViewState.error;
          log("No cached data found.");
        }
      } else {
        await fetchAndCacheData(urlPath);
      }
    } catch (e) {
      _viewState = ViewState.error;
      log("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  set reservations(List<Reservation> value) {
    _reservations = value;
    notifyListeners();
  }

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }
}
