part of 'nextpray_cubit.dart';

@immutable
sealed class NextprayState {}

final class NextprayInitial extends NextprayState {}

final class NextprayLoading extends NextprayState {}

final class NextpraySuccess extends NextprayState {}

final class NextprayError extends NextprayState {
  final String message;
  NextprayError({required this.message});
}
