part of 'download_cubit.dart';

@immutable
sealed class DownloadState {}

final class DownloadInitial extends DownloadState {}
final class DownloadedSursloading extends DownloadState {}
final class DownloadedSursSuccess extends DownloadState {}
final class DownloadedSursFailure extends DownloadState {
  final String errorMessage;
  DownloadedSursFailure(this.errorMessage);
}
