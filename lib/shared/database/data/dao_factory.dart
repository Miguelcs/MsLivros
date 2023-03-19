import 'package:livros/shared/database/dao/livro_dao.dart';

class DaoFactory {
  static LivroDAO? _livroDAO;

  static LivroDAO obterLivroDAO() {
      return _livroDAO ??= LivroDAO();
  }
}