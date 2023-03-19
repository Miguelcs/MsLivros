// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:flutter/material.dart';
// import 'package:livros/shared/bloc/atualizar_bloc.dart';
// import 'package:livros/shared/bloc/livros_bloc.dart';
// import 'package:livros/shared/database/model/livro.dart';
// import 'package:livros/shared/enumeradores/livro_enum.dart';
// import 'package:livros/shared/util/nav.dart';
// import 'package:livros/shared/util/util.dart';
// import 'package:livros/ui/pages/cadastro/cadastro_livro_page.dart';
// import 'package:livros/ui/pages/home/widgets/home_page_icons.dart';
// import 'package:livros/ui/pages/livros/pages/livros_page.dart';
// import 'package:livros/ui/pages/pesquisar/pesquisa_livros_page.dart';
// import 'package:livros/ui/widgets/container_progress.dart';
// import 'package:livros/ui/widgets/livro_listview.dart';
//
// class CadastrosPage extends StatefulWidget {
//   @override
//   _CadastrosPageState createState() => _CadastrosPageState();
// }
//
// class _CadastrosPageState extends State<CadastrosPage> with TickerProviderStateMixin {
//   final _bloc = BlocProvider.getBloc<AtualizarBloc>();
//   final _blocL = BlocProvider.getBloc<LivrosBloc>();
//   List<Livro> livros = [];
//
//   int count = 0;
//   Future future;
//   AnimationController controller;
//   Animation<double> animation;
//   var showProgress = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     configurarAnimacao();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     iniciouCadastro = true;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Livros'),
//         actions: <Widget>[
//           HomePageIcons(false, null, this._pesquisar, null)
//         ],
//       ),
//       body: Container(
//         decoration: DecorationLogo.decoration(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             StreamBuilder(
//                 stream: _bloc.stream,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData && snapshot.data) {
//                     _blocL.obterLivros();
//                     return Container();
//                   } else {
//                     return ContainerProgress();
//                   }
//                 }),
//             showProgress ? Center(child: CircularProgressIndicator(),)
//                 : StreamBuilder<List<Livro>>(
//               stream: _blocL.stream,
//               builder: (context, snapshot) {
//                 print('object');
//
//                 if (snapshot.hasData) {
//                   if (snapshot.data != null) {
//                     livros = snapshot.data;
//                     return LivroListView(
//                       livros,
//                       _detalhes,
//                       animation,
//                       heroCad: true,
//                       blocA: _bloc,
//                     );
//                   } else {
//                     return ContainerProgress();
//                   }
//                 } else {
//                   return ContainerProgress();
//                 }
//               },
//             ),
//
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         heroTag: 'Novo',
//         child: Icon(Icons.add),
//         onPressed: () {
//           cadastrar();
//         },
//       ),
//     );
//   }
//
//   _detalhes(context, Livro livro) async {
//     bool atualizar = await push(context, CadastroLivroPage(livro));
//     print(atualizar);
//
//     if (atualizar != null && atualizar) {
//       _blocL.obterLivros();
//     }
//   }
//
//   Future _pesquisar() async {
//     Livro livro = await push(context, PesquisarLivrosPage());
//
//     if (livro != null && livro.id != null) {
//       push(context, CadastroLivroPage(livro));
//     }
//   }
//
//   Future<void> cadastrar() async {
//     bool atualizar = await push(context, CadastroLivroPage(null));
//     print(atualizar);
//
//     if (atualizar != null && atualizar) {
//       _blocL.obterLivros();
//     }
//   }
//
//   void iniciarAnimacao() {
//     setState(() {
//       showProgress = true;
//     });
//
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         showProgress = false;
//         configurarAnimacao();
//       });
//     });
//   }
//
//   void configurarAnimacao() {
//     controller = AnimationController(
//         duration: const Duration(milliseconds: 800), vsync: this);
//     animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
//     controller.forward();
//   }
//
//   _onClickAtualizar() {
//     _blocL.obterLivros();
//   }
// }//230
