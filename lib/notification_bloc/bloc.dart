import 'package:adapta_hello/models/notification_model.dart';
import 'package:adapta_hello/notification_bloc/event.dart';
import 'package:adapta_hello/notification_bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  // mock notifications data
  List<dynamic> mockNotifications = [
    {
      "id": "1",
      "title": "Aanvraagformulier ontvangen",
      "subtitle": "Ontvangen aanvraagformulier verpleging thuis",
      "icon": "notifications_outlined",
      "color": "orange",
      "time": "2025-08-30T11:40:00",
      "status": "unhandled",
    },
    {
      "id": "2",
      "title": "S. Tetteren",
      "subtitle":
          "Het deksel is niet gesloten en de medicatie kan daardoor niet worden uitgegeven.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-29T13:45:00",
      "status": "unhandled",
    },
    {
      "id": "3",
      "title": "C. Tan",
      "subtitle":
          "Controleer de alarmfunctionaliteit. Het alarm dat ontstaat kan veilig worden genegeerd.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-29T14:40:00",
      "status": "unhandled",
    },
    {
      "id": "4",
      "title": "S. Tetteren",
      "subtitle":
          "Het deksel is niet gesloten en de medicatie kan daardoor niet worden uitgegeven.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-30T11:40:00",
      "status": "inProgress",
    },
    {
      "id": "5",
      "title": "Aanvraagformulier ontvangen",
      "subtitle": "Ontvangen aanvraagformulier verpleging thuis",
      "icon": "notifications_outlined",
      "color": "orange",
      "time": "2025-08-30T11:40:00",
      "status": "completed",
    },
  ];

  NotificationBloc() : super(NotificationLoading()) {

    // Load notifications
    on<LoadNotifications>((event, emit) async {
      emit(NotificationLoading());

      // Simulate a delay for loading
      await Future.delayed(Duration(seconds: 1));

      try {
        final notificationsData = mockNotifications;
        final List<NotificationModel> unhandledNotifications = notificationsData
            .where((n) => n['status'] == 'unhandled')
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        final List<NotificationModel> inProgressNotifications =
            notificationsData
                .where((n) => n['status'] == 'inProgress')
                .map((json) => NotificationModel.fromJson(json))
                .toList();

        final List<NotificationModel> completedNotifications = notificationsData
            .where((n) => n['status'] == 'completed')
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        final List<NotificationModel> allNotifications = notificationsData
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        emit(
          NotificationLoaded(
            unhandled: unhandledNotifications,
            inProgress: inProgressNotifications,
            completed: completedNotifications,
            all: allNotifications,
          ),
        );
      } catch (e) {
        emit(NotificationError('Failed to load notifications'));
      }
    });

    // Update notification status
    on<UpdateNotificationStatus>((event, emit) {
      if (state is NotificationLoaded) {
        final currentState = state as NotificationLoaded;

        final index = currentState.all.indexWhere((n) => n.id == event.id);

        if (index != -1) {
          NotificationModel updatedNotification = currentState.all[index];
          updatedNotification.status = event.newStatus;

          // Update the mock data
          mockNotifications.removeWhere((n) => n['id'] == event.id);
          mockNotifications.add(updatedNotification.toJson());

          // reload notifications
          add(LoadNotifications());
        }
      }
    });
  }
}
