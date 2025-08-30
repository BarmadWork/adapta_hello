import 'package:adapta_hello/notification_bloc/event.dart';
import 'package:adapta_hello/notification_bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  // mock notifications data
  final List<dynamic> notifications = [
    {
      "title": "Aanvraagformulier ontvangen",
      "subtitle": "Ontvangen aanvraagformulier verpleging thuis",
      "icon": "notifications_outlined",
      "color": "yellow",
      "time": "2025-08-30T11:40:00",
    },
    {
      "title": "S. Tetteren",
      "subtitle":
          "Het deksel is niet gesloten en de medicatie kan daardoor niet worden uitgegeven.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-29T13:45:00",
    },
    {
      "title": "C. Tan",
      "subtitle":
          "Controleer de alarmfunctionaliteit. Het alarm dat ontstaat kan veilig worden genegeerd.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-29T14:40:00",
    },
  ];

  NotificationBloc() : super(NotificationLoading()) {
    on<LoadNotifications>((event, emit) async {
      emit(NotificationLoading());

      // Simulate a delay for loading
      await Future.delayed(Duration(seconds: 2));

      try {
        final notifications = this.notifications;
        emit(NotificationLoaded(notifications));
      } catch (e) {
        emit(NotificationError('Failed to load notifications'));
      }
    });
  }
}
