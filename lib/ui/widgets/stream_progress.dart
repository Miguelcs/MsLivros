//import 'package:flutter/material.dart';
//import 'package:imperium_control/domain/bloc/progress_bloc.dart';
//import 'package:imperium_control/domain/shared.interfaces/on_click_listener.dart';
//import 'package:imperium_control/domain/util/cor.dart';
//import 'package:imperium_control/domain/widgets/container_progress.dart';
//import 'package:imperium_control/domain/widgets/icone_button.dart';
//import 'package:ui.pages.livros/bloc/blocs.dart';
//
//class StreamProgress extends StatelessWidget {
//  final ProgressBloc _bloc;
//  final OnClickListener _listener;
//  final GlobalKey<FormState> _formKey;
//
//  const StreamProgress(this._bloc, this._listener, this._formKey);
//
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<bool>(
//      stream: _bloc.stream,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return Container(
//            height: 46,
//            margin: EdgeInsets.only(top: 20),
//            child: RaisedButton(
//              color: Color(Cor.background),
//              child: IconeButton(
//                snapshot.data,
//                iconSize: 50.0,
//              ),
//              onPressed: () {
//                final form = _formKey.currentState;
//                bool valido = true;
//
//                if (!form.validate()) {
//                  valido = false;
//                }
//                _bloc.onClick(true);
//                _listener.onClick(valido);
//              },
//            ),
//          );
//        } else
//          return ContainerProgress();
//      },
//    );
//  }
//}
