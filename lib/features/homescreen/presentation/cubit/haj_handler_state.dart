part of 'haj_handler_cubit.dart';

@immutable
sealed class HajHandlerState {}

final class HajHandlerInitial extends HajHandlerState {}

final class HajHandlerLoading extends HajHandlerState {}
final class HajHandlerSuccess extends HajHandlerState {
  final List<ManasikModel> manasikList;
  HajHandlerSuccess(this.manasikList);
}
final class HajHandlerError extends HajHandlerState {
  final String message;
  HajHandlerError(this.message);
}
