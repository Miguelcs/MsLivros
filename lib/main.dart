import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/bloc/configuracoes_bloc.dart';
import 'package:livros/shared/bloc/drop_down_bloc.dart';
import 'package:livros/shared/bloc/isbn_bloc.dart';
import 'package:livros/shared/bloc/livros_bloc.dart';
import 'package:livros/shared/bloc/preco_bloc.dart';
import 'package:livros/shared/bloc/progress_bloc.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';
import 'package:livros/shared/bloc/url_bloc.dart';
import 'package:livros/ui/pages/splash/splash_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MSLivrosApp());
}

class MSLivrosApp extends StatelessWidget {
  const MSLivrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    obterPermissao();

    return BlocProvider(
      blocs: [
        Bloc((i) => AtualizarBloc()),
        Bloc((i) => LivrosBloc()),
        Bloc((i) => UrlBloc()),
        Bloc((i) => DropDownBloc()),
        Bloc((i) => ISBNBloc()),
        Bloc((i) => PrecoBloc()),
        Bloc((i) => SincronizacaoBloc()),
        Bloc((i) => ConfiguracoesBloc()),
        Bloc((i) => ProgressBloc())
      ],
      dependencies: const [],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale("en"), Locale("es"), Locale("pt, 'BR'")],
        locale: const Locale('pt'),
        debugShowCheckedModeBanner: false,
        title: 'Livros',
        theme: ThemeData(
          hintColor: const Color(0xFF003c8f),
          primaryColor: const Color(0xFF002171),
          appBarTheme: const AppBarTheme(
              color: Color(0xFF002171),
          )
        ),
        home: const SplashPage(),
      ),
    );
  }

  obterPermissao() async {
    await [
      Permission.camera,
      Permission.storage,
    ].request();
  }
}
