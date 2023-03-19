import 'package:flutter/material.dart';
import 'package:livros/shared/database/data/livro_db.dart';
import 'package:livros/shared/services/firebase_service.dart';
import 'package:livros/shared/services/model/preferences.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/shared/util/util.dart';
import 'package:livros/ui/pages/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future futureA = LivroDB.getInstance().initDb();
    Future futureE = Preferences.obterOrdenacao();
    Future futureG = Preferences.obterAlteracaoPaginas();
    Future futureH = FirebaseService().login('daianalanca@gmail.com', 'DaianaAmorinL@03121991');

    // inicia o banco uma única vez
    Future.wait([futureA, futureE, futureG, futureH]).then((List values) {
      ordenacao = values[1];
      splash(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF002171),
      child: Center(
        child: Image.asset("assets/images/ic_logo.png"),
      ),
    );
  }

  void splash(BuildContext context) {
    pushReplacement(context, const HomePage());
  }
}
