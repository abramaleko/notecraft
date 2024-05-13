import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/models/note.dart';
import 'package:notecraft/views/new_note.dart';
import 'package:notecraft/views/notes.dart';
import 'package:notecraft/views/view_note.dart';
import 'package:notecraft/widgets/AppBottomNavbar.dart';

class AppRoutes {
  final GlobalKey<NavigatorState> _rootNavigatorKey;
  final GlobalKey<NavigatorState> _shellNavigatorKey;

  AppRoutes()
      : _rootNavigatorKey = GlobalKey<NavigatorState>(),
        _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get routes => GoRouter(navigatorKey: _rootNavigatorKey, routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return AppBottomNavbar();
            },
            routes: [
              GoRoute(
                  path: '/',
                  builder: (context, state) => Notes(),
                  name: 'home',
                  routes: [
                    GoRoute(
                        path: 'new-note',
                        builder: (context, state) => NewNote(),
                        name: 'new-note'),
                    GoRoute(
                        path: 'view-note',
                        builder: (context, state) {
                          Note note = state.extra as Note;
                          return ViewNote(note: note);
                        },
                        name: 'view-note')
                  ]),
            ])
      ]);
}
