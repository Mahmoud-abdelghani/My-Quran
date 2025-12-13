import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran/core/database/cache_helper.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  static late bool serviceEnabled;
  static late LocationPermission locationPermission;
  String? loction;
  String? address;
  String? zone;
  getLocation() async {
    emit(LocationLoading());
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationError("enable Lcation"));
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        emit(LocationError("permission required"));
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      emit(LocationError("Location Services doesn't work"));
      await openAppSettings();
    }
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    ).timeout(const Duration(seconds: 15));
    Placemark place = places.first;
    loction = place.administrativeArea;
    address = place.country;
    tz.initializeTimeZones();
    final TimezoneInfo currentTimeZone =
        await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    zone = tz.local.toString();
    await CacheHelper.storeString('Location', address.toString());
    await CacheHelper.storeString('Zone', zone ?? "Africa/Cairo");
    emit(
      LocationSuccess(address: address.toString(), zone: tz.local.toString()),
    );
  }
}
