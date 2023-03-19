// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:livros/shared/bloc/atualizar_bloc.dart';
// import 'package:livros/shared/bloc/livros_bloc.dart';
// import 'package:livros/shared/database/model/livro.dart';
// import 'package:livros/shared/util/nav.dart';
// import 'package:livros/ui/pages/cadastro/cadastro_livro_page.dart';
// import 'package:livros/ui/pages/livros/pages/livros_page.dart';
// import 'package:livros/ui/widgets/livro_listview.dart';
//
// class LivrosPesquisaPage extends StatefulWidget {
//   final AtualizarBloc _bloc;
//   final LivrosBloc _blocL;
//   final Animation<double> animation;
//
//   LivrosPesquisaPage(this._bloc, this._blocL, this.animation);
//
//   @override
//   _LivrosPesquisaPageState createState() => new _LivrosPesquisaPageState();
// }
//
// class _LivrosPesquisaPageState extends State<LivrosPesquisaPage> {
//   AtualizarBloc get _bloc => widget._bloc;
//   LivrosBloc get _blocL => widget._blocL;
//   Animation<double> get animation => widget.animation;
//
//   final TextEditingController _filter = new TextEditingController();
//   Icon _searchIcon = new Icon(Icons.close);
//   var focusNode = new FocusNode();
//   var query = '';
//
//   @override
//   void initState() {
//     super.initState();
//     model.obterTodosPorDescricao('');
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildBar(context),
//       body: Container(
//         decoration: DecorationLogo.decoration(),
//         child: _buildList(),
//       ),
//       resizeToAvoidBottomPadding: false,
//     );
//   }
//
//   Widget _buildBar(BuildContext context) {
//     return new AppBar(
//       title: TextField(
//         focusNode: focusNode,
//         style: TextStyle(color: Colors.white),
//         controller: _filter,
//         onChanged: (value) {
//           this.query = value;
//           _obterCliente(value);
//         },
//         decoration: new InputDecoration(
//             prefixIcon: new Icon(Icons.close), hintText: 'Pesquisar'),
//       ),
//       actions: [
//         IconButton(
//           icon: _searchIcon,
//           onPressed: _searchPressed,
//         ),
//       ],
//     );
//   }
//
//   List<Livro> livros;
//
//   Widget _buildList() {
//     FocusScope.of(context).requestFocus(focusNode);
//     return Observer(
//       builder: (context) {
//         if (model.error != null) {
//           return Container(
//             child: Center(
//               child: Text(
//                 model.error.toString(),
//                 style: TextStyle(fontSize: 19.0, color: Colors.white),
//               ),
//             ),
//           );
//         }
//
//         if (model.result == null) {
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           if (model.result != null) {
//             livros = model.result;
//             return Container(
//               padding: EdgeInsets.only(top: 10),
//               child: LivroListView(
//                 livros,
//                 _detalhes,
//                 animation,
//                 heroCad: true,
//                 blocA: _bloc,
//               )
//             );
//           } else {
//             return Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         }
//       },
//     );
//   }
//
//   void _searchPressed() {
//     if (this._searchIcon.icon == Icons.search) {
//       this._searchIcon = new Icon(Icons.close);
//       FocusScope.of(context).requestFocus(focusNode);
//     } else {
//       this._searchIcon = new Icon(Icons.search);
//       FocusScope.of(context).unfocus();
//       _filter.clear();
//       model.result = null;
//     }
//   }
//
//   void _obterCliente(String query) async {
//     model.obterTodosPorDescricao(query);
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
// }
