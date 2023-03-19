import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class ItensTabBar extends StatelessWidget {
  final AtualizarBloc _bloc;
  final bool grid;
  final int categoria;

  const ItensTabBar(this._bloc, this.grid, this.categoria);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LivrosPage(categoria, grid);
        } else {
          return ContainerProgress();
        }
      },
    );
  }

}
