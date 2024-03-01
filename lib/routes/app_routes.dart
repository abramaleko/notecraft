import 'package:go_router/go_router.dart';
import 'package:notecraft/views/new_note.dart';
import 'package:notecraft/views/notes.dart';

class AppRoutes {
  final routes = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => Notes(),
        name: 'home',
        routes: [
          GoRoute(
              path: 'new-note',
              builder: (context, state) => NewNote(),
              name: 'new-note')
        ]),
  ]);
}
