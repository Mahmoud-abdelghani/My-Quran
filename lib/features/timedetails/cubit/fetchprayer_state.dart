part of 'fetchprayer_cubit.dart';

@immutable
sealed class FetchprayerState {}

final class FetchprayerInitial extends FetchprayerState {}

final class FetchprayerLoading extends FetchprayerState {}

final class FetchprayerSuccess extends FetchprayerState {
  final PrayersTimesModel prayers;
  FetchprayerSuccess({required this.prayers});
}

final class FetchprayerError extends FetchprayerState {
  final String message;
  FetchprayerError({required this.message});
}
