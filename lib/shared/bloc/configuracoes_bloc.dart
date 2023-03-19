import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ConfiguracoesBloc extends BlocBase {
  final _controller = BehaviorSubject<bool>();

  get stream => _controller.stream;

  exibir(bool exibir) {
    Future.delayed(Duration(seconds: 1), () {
      _controller.sink.add(exibir);
    });
    _controller.sink.add(false);
  }

  void close() {
    _controller.close();
  }
}

