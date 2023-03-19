import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class UrlBloc extends BlocBase {
  final _controller = BehaviorSubject<bool>();

  get stream => _controller.stream;

  obterUrl(bool exibir) {
    _controller.sink.add(exibir);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}