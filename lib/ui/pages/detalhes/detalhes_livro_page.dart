import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/dialog/foto_dialog.dart';
import 'package:livros/ui/pages/detalhes/widgets/titulo_livro.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/pages/livros/widgets/conteudo_livro.dart';
import 'package:livros/ui/pages/livros/widgets/detalhes_livro.dart';
import 'package:livros/ui/widgets/livro_titulo.dart';

class DetalhesLivroPage extends StatefulWidget {
  DetalhesLivroPage(this.livro);

  final Livro livro;

  @override
  _DetalhesLivroPageState createState() => _DetalhesLivroPageState();
}

class _DetalhesLivroPageState extends State<DetalhesLivroPage> with TickerProviderStateMixin {
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    var controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LivroTitulo('Detalhes - Livro', '${widget.livro.titulo}'),
      ),
      body: FadeTransition(
        opacity: animation,
        child: Container(
          decoration: DecorationLogo.decoration(),
          child: ListView(
            children: <Widget>[
              TituloLivro(
                livro: widget.livro,
              ),
              DetalhesLivro(widget.livro, () {
                _onClick(context, widget.livro);
              }),
              ConteudoLivro(widget.livro),
            ],
          ),
        ),
      ),
    );
  }

  _onClick(context, livro) {
    showDialog(
        context: context, builder: (BuildContext context) => FotoDialog(livro));
  }
}
