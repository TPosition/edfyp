import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eispkp/user_type_select/user_type_select.dart';
import '/app/app.dart';
import '/auth_select/auth_select.dart';
import '/common/widgets/bottom_nav_bar.dart';
import '/info_update/view/view.dart';

List<Page> onGenerateAppViewPages(
  final UserStatus state,
  final List<Page<dynamic>> pages,
) {
  switch (state) {
    case UserStatus.appStatusUnauthenticated:
      return [AuthSelect.page()];
    case UserStatus.currentUserStatusIncompleted:
      return [UserTypeSelectPage.page()];
    case UserStatus.currentUserStatusCompleted:
      return [BottomNavBar.page()];
  }
}
