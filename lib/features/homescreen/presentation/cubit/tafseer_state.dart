part of 'tafseer_cubit.dart';

@immutable
sealed class TafseerState {}

final class TafseerInitial extends TafseerState {}

final class TafseerTypesLoading extends TafseerState {}

final class TafseerTypesSuccess extends TafseerState {
  final List<TafseerTypeModel> tafseerBooks;
  TafseerTypesSuccess({required this.tafseerBooks});
}

final class TafseerTypesError extends TafseerState {
  final String message;
  TafseerTypesError({required this.message});
}
