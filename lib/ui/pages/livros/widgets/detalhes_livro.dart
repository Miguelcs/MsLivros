import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/pages/livros/widgets/info_detalhes_livro.dart';
import 'package:livros/ui/pages/livros/widgets/info_foto_livro.dart';

class DetalhesLivro extends StatefulWidget {
  final Livro livro;
  final Function _onClick;
  final bool heroCad;
  final bool detalhes;

  const DetalhesLivro(this.livro, this._onClick,
      {super.key, this.heroCad = false, this.detalhes = true});

  @override
  _DetalhesLivroState createState() => _DetalhesLivroState();
}

class _DetalhesLivroState extends State<DetalhesLivro> {
  Livro get livro => widget.livro;
  final _bloc = BlocProvider.getBloc<AtualizarBloc>();

  bool get hero => widget.heroCad;

  Function get _onClick => widget._onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          _onClick();
        },
        child: Card(
          elevation: 1.0,
          color: Colors.white,
          //margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              !widget.detalhes
                  ? Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        livro.titulo ?? '',
                        style: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InfoFotoLivro(
                    livro,
                    heroCad: hero,
                  ),
                  StreamBuilder<bool>(
                    initialData: true,
                    stream: _bloc.stream,
                    builder: (context, snapshot) {
                      return InfoDetalhesLivro(livro);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
