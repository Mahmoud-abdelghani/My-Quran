part of 'get_tafseer_cubit.dart';

@immutable
sealed class GetTafseerState {}

final class GetTafseerInitial extends GetTafseerState {}

final class GetTafseerLoading extends GetTafseerState {}

final class GetTafseerSuccess extends GetTafseerState {
  final List<AyaTafseer> tafseerOfAyats;
  GetTafseerSuccess({required this.tafseerOfAyats});
}

final class GetTafseerError extends GetTafseerState {
  final String error;
  GetTafseerError({required this.error});
}
