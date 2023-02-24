import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'screens/no_profile.dart';
import 'screens/profile_manage.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthenticationController>(context).currentUser;
    bool isLoggedIn = user != null;

    if (isLoggedIn) {
      return const ProfileManageScreen();
    } else {
      return const NoProfileScreen();
    }
  }
}
