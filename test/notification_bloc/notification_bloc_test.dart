import 'package:adapta_hello/notification_bloc/bloc.dart';
import 'package:adapta_hello/notification_bloc/event.dart';
import 'package:adapta_hello/notification_bloc/state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationBloc', () {
    late NotificationBloc notificationBloc;

    setUp(() {
      notificationBloc = NotificationBloc();
    });

    tearDown(() {
      notificationBloc.close();
    });

    test('initial state is NotificationLoading', () {
      expect(notificationBloc.state, isA<NotificationLoading>());
    });

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoading, NotificationLoaded] when LoadNotifications is added',
      build: () => NotificationBloc(),
      act: (bloc) => bloc.add(LoadNotifications()),
      wait: const Duration(seconds: 3), // simulate loading time
      expect: () => [isA<NotificationLoading>(), isA<NotificationLoaded>()],
    );

    blocTest<NotificationBloc, NotificationState>(
      'NotificationLoaded contains the mock notifications',
      build: () => NotificationBloc(),
      act: (bloc) => bloc.add(LoadNotifications()),
      wait: const Duration(seconds: 3), // simulate loading time
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<NotificationLoaded>());
        if (state is NotificationLoaded) {
          expect(state.notifications.length, 3);
        }
      },
    );
  });
}
