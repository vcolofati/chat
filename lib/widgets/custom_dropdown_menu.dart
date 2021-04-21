import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        items: [
          DropdownMenuItem(
            value: 'logout',
            child: Container(
              child: Row(
                children: [
                  const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  const Text('Sair'),
                ],
              ),
            ),
          ),
        ],
        onChanged: (item) {
          if (item == 'logout') FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}
