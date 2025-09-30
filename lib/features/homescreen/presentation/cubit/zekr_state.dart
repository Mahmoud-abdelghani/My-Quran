part of 'zekr_cubit.dart';

@immutable
sealed class ZekrState {}

final class ZekrInitial extends ZekrState {}

final class ZekrLoading extends ZekrState {}

final class ZekrSuccess extends ZekrState {}

final class ZekrError extends ZekrState {
  final String message;
  ZekrError({required this.message});
}
