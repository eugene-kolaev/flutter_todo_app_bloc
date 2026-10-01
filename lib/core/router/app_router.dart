import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_todo_app/features/notes/presentation/view/edit_note_page.dart';
import 'package:flutter_todo_app/features/notes/presentation/view/notes_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter  {
  @override
  List<AutoRoute> get routes => <AutoRoute> [
    AutoRoute(page: NotesRoute.page, initial: true),
    AutoRoute(page: EditNoteRoute.page, path: '/edit/:id'),
  ];
}