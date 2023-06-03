import 'package:flutter/material.dart';
import 'package:my_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOutTap;

  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
                // List Tile
                MyListTile(
                  icon: Icons.home,
                  text: 'H O M E',
                  onTap: () => Navigator.pop(context),
                ),

                // profile list tile
                MyListTile(
                    icon: Icons.person,
                    text: 'P R O F I L E',
                    onTap: onProfileTap),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MyListTile(
                  icon: Icons.logout, text: 'L O G O U T', onTap: onSignOutTap),
            )
          ],
        ));
  }
}
