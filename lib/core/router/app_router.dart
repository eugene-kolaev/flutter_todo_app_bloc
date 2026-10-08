import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_todo_app/core/router/auth_guard.dart';
import 'package:flutter_todo_app/core/router/splash_page.dart';
import 'package:flutter_todo_app/features/notes/presentation/view/edit_note_page.dart';
import 'package:flutter_todo_app/features/notes/presentation/view/notes_page.dart';
import 'package:injectable/injectable.dart';
import '../../features/auth/presentation/view/login_page.dart';
import '../../features/auth/presentation/view/register_page.dart';
import 'guest_guard.dart';
import 'splash_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@lazySingleton
class AppRouter extends RootStackRouter {
  final SplashGuard splashGuard;
  final AuthGuard authGuard;
  final GuestGuard guestGuard;

  AppRouter(this.authGuard, {required this.guestGuard, required this.splashGuard});



  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: LoginRoute.page, initial: true, guards: [guestGuard]),
    AutoRoute(page: RegisterRoute.page, path: '/register', guards: [guestGuard]),
    AutoRoute(page: NotesRoute.page, path: '/notes', guards: [authGuard]),
    AutoRoute(page: EditNoteRoute.page, path: '/edit/:id', guards: [authGuard]),
  ];
}
