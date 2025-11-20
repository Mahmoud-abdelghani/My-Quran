import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'notification_memory_state.dart';

class NotificationMemoryCubit extends HydratedCubit<bool> {
  NotificationMemoryCubit() : super(true);

  toggleNotifications() {
    emit(state ? false : true);
  }

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['NotificatationState'] as bool;
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'NotificatationState': state};
  }
}
