import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';
import 'package:livros/ui/pages/home/tabs/widgets/container_progress_message.dart';
import 'package:livros/ui/pages/home/tabs/widgets/itens_tab_bar.dart';

class LendoPage extends StatelessWidget {
  final SincronizacaoBloc _blocSincronizacao;
  final AtualizarBloc _bloc;
  final bool grid;

  LendoPage(this._blocSincronizacao, this._bloc, this.grid);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Sincroniza>(
      stream: _blocSincronizacao.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.exibir == true) {
          return ContainerProgressMessage(snapshot.data?.mensagem ?? '');
        }
        return ItensTabBar(_bloc, grid, 1);
      },
    );
  }
}
