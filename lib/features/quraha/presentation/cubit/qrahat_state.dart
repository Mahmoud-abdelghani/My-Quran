part of 'qrahat_cubit.dart';

@immutable
sealed class QrahatState {}

final class QrahatInitial extends QrahatState {}

final class QraaLoading extends QrahatState {}

final class QraaSuccess extends QrahatState {}

final class QraaError extends QrahatState {
  final String message;
  QraaError({required this.message});
}
