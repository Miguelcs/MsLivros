import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/services/firebase_service.dart';
import 'package:livros/shared/util/alertas.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/ui/dialog/mensagem_dialog.dart';
import 'package:livros/ui/pages/cadastro/cadastro_livro_page.dart';
import 'package:livros/ui/pages/livros/widgets/detalhes_livro.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class LivroListView extends StatefulWidget {
  final List<Livro>? lista;
  final Function _onClick;
  final Animation<double>? animation;
  final TickerProviderStateMixin provider;

  const LivroListView(this.lista, this._onClick, this.animation, this.provider, {super.key});

  @override
  _LivroListViewState createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  final _blocSincronizacao = BlocProvider.getBloc<SincronizacaoBloc>();
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    int itens =  widget.lista?.length ?? 0;

    var controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: widget.provider);
    var nanimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    return Expanded(
      child: widget.animation != null ? FadeTransition(
        opacity: widget.animation ?? nanimation,
        child: progress ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerProgress(),
            const Text('Excluindo Livro...', style: TextStyle(color: Colors.white),)
          ],
        )) :
        obterLista(itens),
      ) : obterLista(itens),
    );
  }

  ListView obterLista(int itens) {
    return ListView.builder(
      itemCount: itens,
      primary: false,
      padding: const EdgeInsets.all(0.5),
      itemBuilder: (BuildContext context, int index) {
        Livro livro = widget.lista![index];

        return Slidable(
          key: Key(livro.tag ?? ''),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                key: Key('${livro.tag}_editar'),
                onPressed: (_) => push(context, CadastroLivroPage(livro)),
                backgroundColor: Colors.blue,
                icon: Icons.edit,
                label: 'Editar',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                key: Key('${livro.tag}_excluir'),
                onPressed: (_) => showDeleteDialog(index),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Excluir',
              ),
            ],
          ),
          child:  Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _containersList(livro, context, true)
              ],
            ),
          ),
        );
      },
    );
  }

  showEditDialog() {
    toast('Edit action');
  }

  showDeleteDialog(index) {
    showDialog(
      context: context,
      builder: (context) {
        return MensagemDialog(
          "Excluir Livro",
          "Deseja realmente excluir o Livro: ${widget.lista![index].titulo}?",
          _onClickSim,
          index: index,
        );
      },
    );
  }

  _onClickSim(context, index) async {
    setState(() {
      progress = true;
    });

    var livro = widget.lista![index];
    widget.lista?.removeAt(index);

    await FirebaseService().excluir(livro);

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        progress = false;
        _blocSincronizacao.sincronizacao(context);
      });
    });
  }

  _containersList(Livro livro, BuildContext context, bool grid) {
    return DetalhesLivro(livro, () {
      widget._onClick(context, livro);
    }, heroCad: false, detalhes: false,);
  }
}

class ListItem extends StatefulWidget {
  final int index;

  const ListItem(this.index, {super.key});

  @override
  RoomEditDeleteItemState createState() => RoomEditDeleteItemState();
}

class RoomEditDeleteItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {

    showEditDialog() {
      toast('Edit action');
    }

    showDeleteDialog() {
      toast( "Delete Action");

      setState(() {

      });
    }

    return InkWell(
        child: Slidable(
          //key: Key(livro.tag ?? ''),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                //key: Key(livro.tag ?? ''),
                onPressed: (ctx) {
                  showEditDialog();
                },
                backgroundColor: Colors.indigo,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                //key: Key(livro.tag ?? ''),
                onPressed: (ctx) {
                  showDeleteDialog();
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              // SlidableAction(
              //   onPressed: doNothing,
              //   backgroundColor: Color(0xFF21B7CA),
              //   foregroundColor: Colors.white,
              //   icon: Icons.share,
              //   label: 'Share',
              // ),
            ],
          ),

          //startActionPane: SlidableDrawerDismissal(),
          child:  Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text('List Item ${widget.index.toString()}'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}//212