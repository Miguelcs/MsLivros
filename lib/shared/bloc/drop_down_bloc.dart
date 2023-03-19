import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:livros/ui/widgets/dropdown.dart';

class DropDownBloc extends BlocBase {
  // Singleton
  static final DropDownBloc _instance = new DropDownBloc.internal();

  factory DropDownBloc() {
    return _instance;
  }

  DropDownBloc.internal();

  final _controller = BehaviorSubject<DropDownItem?>();

  get stream => _controller.stream;

  void obter(DropDownItem? valor) {
    _controller.sink.add(valor);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}