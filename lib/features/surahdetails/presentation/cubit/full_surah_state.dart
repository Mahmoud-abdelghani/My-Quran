part of 'full_surah_cubit.dart';

@immutable
sealed class FullSurahState {}

final class FullSurahInitial extends FullSurahState {}

final class FullSurahLoading extends FullSurahState {}

final class FullSurahSuccess extends FullSurahState {
  final FullSurahModel fullSurahModel;
  FullSurahSuccess({required this.fullSurahModel});
}

final class FullSurahconnectionError extends FullSurahState {
  final String message;
  FullSurahconnectionError({required this.message});
}
