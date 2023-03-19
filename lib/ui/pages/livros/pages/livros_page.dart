import 'package:flutter/material.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/util/util.dart';
import 'package:livros/ui/pages/home/widgets/home_page_livros.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class LivrosPage extends StatefulWidget {
  final bool grid;
  final int _categoria;

  const LivrosPage(this._categoria, this.grid, {super.key});

  @override
  _LivrosPageState createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> with TickerProviderStateMixin {
  var totalItens = 1;
  List<Livro> livros = [];

  bool get grid => widget.grid;
  Future? future;
  var showProgress = false;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    configurarAnimacao();
    verificarUrl();
    LivroDAO livroDAO = DaoFactory.obterLivroDAO();

    if (widget._categoria > 0) {
      future = livroDAO.obterLivrosPorCategoria(widget._categoria);
    } else {
      future = livroDAO.obterLivrosPor(ordenacao);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cadastro) {
      LivroDAO livroDAO = DaoFactory.obterLivroDAO();
      future = livroDAO.obterLivrosPor(ordenacao);
      cadastro = false;
    }

    return Scaffold(
      body: Container(
        decoration: DecorationLogo.decoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showProgress ? const Center(child: CircularProgressIndicator(),)
                : FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  livros = [];
                  livros = snapshot.data;
                  return HomePageLivros(livros, grid, animation, this);
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Sem dados",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontStyle: FontStyle.italic),
                    ),
                  );
                } else {
                  return ContainerProgress();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void iniciarAnimacao() {
    setState(() {
      showProgress = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        showProgress = false;
        configurarAnimacao();
      });
    });
  }

  void configurarAnimacao() {
    var controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }
} //154

class DecorationLogo {
  static decoration(){
    return const BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/images/preview_dog-and-owl-reading-a-book.jpg'),fit: BoxFit.cover),
    );
  }
}