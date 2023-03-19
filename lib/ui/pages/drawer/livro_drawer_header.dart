import 'package:flutter/material.dart';

class LivroDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        'Livros',
        style: TextStyle(color: Colors.white),
      ),
      accountEmail: Text(
        'miguelguerreiroc@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(
              'assets/images/ic_banner.jpg',
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.blueAccent),
    );
  }
}
