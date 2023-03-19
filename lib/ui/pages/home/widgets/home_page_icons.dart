import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/ui/pages/home/widgets/popup_ordenar.dart';

class HomePageIcons extends StatefulWidget {
  final bool grid;
  final Function _onClickGrid;
  final Function _onClickPesquisar;
  final Function _onClickOrdenar;

  const HomePageIcons(this.grid, this._onClickGrid, this._onClickPesquisar,
      this._onClickOrdenar, {super.key});

  @override
  _HomePageIconsState createState() => _HomePageIconsState();
}

class _HomePageIconsState extends State<HomePageIcons> {
  final _bloc = BlocProvider.getBloc<AtualizarBloc>();

  @override
  void initState() {
    _bloc.exibir(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool grids = widget.grid;

    return Row(
      children: <Widget>[
        PopupOrdenar(
          widget._onClickOrdenar,
          expand: false,
        ),
        StreamBuilder(
          stream: _bloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return IconButton(
                icon: Image.asset(
                  'assets/images/${!grids ? 'ic_grid.png' : 'ic_list.png'}',
                  color: Colors.white,
                  height: 24,
                ),
                onPressed: () {
                  widget._onClickGrid(grids);
                  grids = !grids;
                },
              );
            } else {
              return Container();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          iconSize: 30,
          onPressed: () {
            widget._onClickPesquisar();
          },
        ),
      ],
    );
  }
}
