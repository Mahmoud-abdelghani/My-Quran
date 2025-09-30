part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final String address;
  LocationSuccess({required this.address});
}

final class LocationError extends LocationState {
  final String errorMessage;
  LocationError(this.errorMessage);
}
