part of 'tasspeh_cubit.dart';

@immutable
sealed class TasspehState {}

final class TasspehInitial extends TasspehState {}

final class TasspehCounterUp extends TasspehState {
  final String txt;
  final int count;
  TasspehCounterUp({required this.count, required this.txt});
}
