import 'package:apside72_ref/models/nav_item.model.dart';
import 'package:apside72_ref/views/nav/nav_header.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  List<NavItemModel> navItems = [];

  @override
  void initState() {
    navItems.add(NavItemModel('', '', 0));
    navItems.add(NavItemModel('images/philippe.jpg', 'Phillipe', 1));
    navItems.add(NavItemModel('images/fmj.png', 'Full Metal Jacket', 2));
    navItems.add(NavItemModel('images/kaamelott.jpg', 'Kaamelott', 3));

    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: navItems.length,
        itemBuilder: (context, index) {
          return index == 0 ? const NavDrawerHeader() : ListTile(
            leading: CircleAvatar(
            backgroundImage: AssetImage(navItems[index].avatar),
          ),
          title: Text(navItems[index].title),
          onTap: () => {},
        );
      })
    );
  }

  
}