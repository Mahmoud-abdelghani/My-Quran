part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final String address;
  final String zone;
  LocationSuccess({required this.address, required this.zone});
}

final class LocationError extends LocationState {
  final String errorMessage;
  LocationError(this.errorMessage);
}
