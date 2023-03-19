import 'package:flutter/material.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class ContainerProgressMessage extends StatelessWidget {
  final String message;

  const ContainerProgressMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: DecorationLogo.decoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
            ),
          ),
          ContainerProgress(),
        ],
      )
    );
  }
}
