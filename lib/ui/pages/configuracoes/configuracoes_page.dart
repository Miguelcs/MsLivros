import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/configuracoes_bloc.dart';
import 'package:livros/shared/services/model/preferences.dart';
import 'package:livros/ui/pages/configuracoes/widgets/config_titulo.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  final _bloc = BlocProvider.getBloc<ConfiguracoesBloc>();

  bool isbn = false;
  bool compra = false;

  @override
  void initState() {
    super.initState();

    _bloc.exibir(false);

    Future futureC = Preferences.obterISBN();
    Future futureD = Preferences.obterCompra();
    Future futureF = Future.delayed(const Duration(seconds: 1));

    // inicia o banco uma única vez
    Future.wait([futureC, futureD, futureF]).then((List values) {
      if (values[0] != null) this.isbn = values[0];

      if (values[1] != null) this.compra = values[1];

      _bloc.exibir(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: StreamBuilder<bool>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Container(
              decoration: DecorationLogo.decoration(),
              child: ListView(
                children: <Widget>[
                  const ConfigTitulo('Geral'),
                  Card(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                              margin:
                              const EdgeInsets.only(left: 20.0, bottom: 3.0, top: 10.0),
                              child: const Text('Habilitar cadastro ISBN')),
                        ),
                        Switch(
                          onChanged: _onSwitchChangedISBN,
                          value: isbn,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                              margin:
                              const EdgeInsets.only(left: 20.0, bottom: 3.0, top: 10.0),
                              child: const Text('Habilitar cadastro Compra')),
                        ),
                        Switch(
                          onChanged: _onSwitchChanged,
                          value: compra,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
                decoration: DecorationLogo.decoration(),
                child: ContainerProgress());
          }
      },),
    );
  }

  void _onSwitchChangedISBN(bool value) {
    isbn = value;
    Preferences.salvarISBN(value);
    setState(() {});
  }

  void _onSwitchChanged(bool value) {
    compra = value;
    Preferences.salvarCompra(value);
    setState(() {});
  }
}
//183