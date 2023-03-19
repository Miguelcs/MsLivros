import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/livros_bloc.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/pages/livros/widgets/livro_input.dart';
import 'package:livros/ui/widgets/container_progress.dart';
import 'package:livros/ui/widgets/livro_listview.dart';

class PesquisarLivrosPage extends StatefulWidget {
  final TickerProviderStateMixin provider;

  const PesquisarLivrosPage({super.key, required this.provider});

  @override
  _PesquisarLivrosPageState createState() => _PesquisarLivrosPageState();
}

class _PesquisarLivrosPageState extends State<PesquisarLivrosPage> with TickerProviderStateMixin {
  final bloc = BlocProvider.getBloc<LivrosBloc>();
  final _tPesquisa = TextEditingController();

  @override
  void initState() {
    bloc.obterLivrosPorDescricao('', exibir: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Livros'),
      ),
      body: Container(
        decoration: DecorationLogo.decoration(),
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 2, bottom: 3),
              child: LivroInput(
                _tPesquisa,
                'Pesquisar',
                'Pesquisar',
                onChanged: _onChanged,
              ),
            ),
            StreamBuilder<List<Livro>>(
              stream: bloc.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return ContainerProgress();

                if (snapshot.hasError) {
                  return Container(
                    child: const Center(
                      child: Text(''),
                    ),
                  );
                }
                return LivroListView(snapshot.data, obterLivro, null, widget.provider);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> obterLivro(context, Livro livro) async {
    if (livro != null) {
      pop(context, livro);
    }
  }

  _onChanged(String texto) {
    if (texto.length > 2) {
      bloc.obterLivrosPorDescricao(texto);
    } else {
      bloc.obterLivrosPorDescricao('', exibir: false);
    }
  }
}
