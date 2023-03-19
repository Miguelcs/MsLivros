import 'package:livros/shared/services/model/preferences.dart';

bool cadastro = false;
bool iniciouCadastro = false;
int ordenacao = 1;

verificarUrl() {
  Preferences.obterUrl().then((url) {
    if (url.isEmpty) {
      Preferences.salvarUrl('127.0.0.1:8080');
    }
  });
}