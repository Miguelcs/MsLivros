import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';

class DrawerListExtension {
  bool _salvar = false;

  salvarLivro(Livro livro) async {
    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    livro.dataHoraCriacao = DateTime.now();
    livro.dataHoraAlteracao = DateTime.now();

    if (livro.id != null) {
      var livroSalvo = await livroDAO.obterPorId(livro.id);

      if (livroSalvo != null) {
        _salvar = await livroDAO.salvar(livro);
        return _salvar;
      }
      _salvar = await livroDAO.inserirComId(livro);
    } else {
      _salvar = await livroDAO.salvar(livro);
    }
    return _salvar;
  }

  deletarTodos() async {
    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    await livroDAO.deletarTodos();
  }
}
