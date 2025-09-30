part of 'quran_cubit.dart';

@immutable
sealed class QuranState {}

final class QuranInitial extends QuranState {}

final class QuranFetchingLoading extends QuranState {}

final class QuranFetchingSuccess extends QuranState {}

final class QuranFetchingError extends QuranState {
  final String message;
  QuranFetchingError({required this.message});
}
