import 'package:flutter/material.dart';

class NavDrawerHeader extends StatelessWidget {
  const NavDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UserAccountsDrawerHeader(
      accountName: Text('Phillipe'),
      accountEmail: Text('--'),
      currentAccountPicture: CircleAvatar(),
    );
  }
}
