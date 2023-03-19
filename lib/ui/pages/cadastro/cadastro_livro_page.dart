import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/bloc/isbn_bloc.dart';
import 'package:livros/shared/bloc/livros_bloc.dart';
import 'package:livros/shared/bloc/preco_bloc.dart';
import 'package:livros/shared/bloc/url_bloc.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/interfaces/on_select_listener.dart';
import 'package:livros/shared/services/model/pais_origem.dart';
import 'package:livros/shared/services/model/preferences.dart';
import 'package:livros/shared/services/model/volume_json.dart';
import 'package:livros/shared/util/alertas.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/shared/util/util.dart';
import 'package:livros/ui/pages/cadastro/widgets/cad_edicao.dart';
import 'package:livros/ui/pages/cadastro/widgets/cad_paginas.dart';
import 'package:livros/ui/pages/cadastro/widgets/cadastro_layout.dart';
import 'package:livros/ui/pages/cadastro/widgets/cadastro_livro_extension.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/pages/livros/pages/pesquisa_livros_page.dart';
import 'package:livros/ui/pages/livros/widgets/livro_button.dart';
import 'package:livros/ui/pages/livros/widgets/livro_image.dart';
import 'package:livros/ui/pages/livros/widgets/livro_input.dart';
import 'package:livros/ui/widgets/container_progress.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';

class CadastroLivroPage extends StatefulWidget {
  final Livro? _livro;

  const CadastroLivroPage(this._livro, {super.key});

  @override
  _CadastroLivroPageState createState() => _CadastroLivroPageState();
}

class _CadastroLivroPageState extends State<CadastroLivroPage> implements OnSelectedListener {
  final _blocSincronizacao = BlocProvider.getBloc<SincronizacaoBloc>();
  Livro? get livroObtido => widget._livro;
  final _blocAtualizar = BlocProvider.getBloc<AtualizarBloc>();
  final _blocISBN = BlocProvider.getBloc<ISBNBloc>();
  final _blocCompra = BlocProvider.getBloc<PrecoBloc>();
  final _blocL = BlocProvider.getBloc<LivrosBloc>();

  String? link;
  XFile? fileP;
  final _formKey = GlobalKey<FormState>();
  final _lyt = CadastroLayout();

  final _bloc = BlocProvider.getBloc<UrlBloc>();
  final _extension = CadastroLivroExtension();

  Livro? novoLivro = Livro();
  final int _lido = 1;

  final List<FocusNode> focus = [];
  int categoria = 3;
  PaisOrigem? _origem;

  VolumeInfo? info;

  bool file = false;
  bool pesquisa = false;

  List<Object> images = <Object>[];
  late Future<XFile?> _imageFile;

  @override
  void initState() {
    super.initState();

    images.add("Add Image");
    link = '/images/fundo.png';
    _bloc.obterUrl(false);

    if (livroObtido != null) {
      _lyt.preencherCamposComLivro(livroObtido);
      categoria = livroObtido?.status ?? 0;
      link = livroObtido?.link;
    }

    Preferences.obterISBN().then((isbn) {
      if (isbn) {
        _blocISBN.exibir(true);
      } else {
        Preferences.salvarISBN(isbn);
      }
    });

    Preferences.obterCompra().then((compra) {
      if (compra) {
        _blocCompra.exibir(true);
      } else {
        Preferences.salvarCompra(compra);
      }
    });
    _blocAtualizar.exibir(true);
  }

  @override
  Widget build(BuildContext context) {
    if (livroObtido != null) {
      novoLivro = livroObtido!;
    }

    if (info != null) {
      _lyt.preencherCamposComLivroPesquisa(info, _bloc);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(novoLivro?.titulo ?? 'Novo Livro'),
      ),
      body: StreamBuilder<bool>(
        stream: _blocAtualizar.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Form(
                key: _formKey,
                child: Container(
                  decoration: DecorationLogo.decoration(),
                  //padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Card(
                        margin: const EdgeInsets.only(top: 2, bottom: 3),
                        child: LivroInput(_lyt.tTitulo, 'Insira um Título', 'Título',
                            focus: _lyt.fTitulo, focusNext: _lyt.fSubtitulo),
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 2, bottom: 3),
                        child: LivroInput(
                          _lyt.tSubtitulo,
                          '',
                          'Subtítulo',
                          focus: _lyt.fSubtitulo,
                          focusNext: _lyt.fFoto,
                          validar: false,
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 2, bottom: 3),
                        child: LivroInput(_lyt.tAutor, 'Insira um Autor', 'Autor',
                            focus: _lyt.fAutor, focusNext: _lyt.fCategorias),
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 2, bottom: 3),
                        child: LivroInput(
                          _lyt.tCategorias,
                          'Insira Categorias',
                          'Categorias',
                          focus: _lyt.fCategorias,
                          focusNext: _lyt.fEdicao,
                          validar: false,
                        ),
                      ),
                      CadEdicao(_lyt.tAnoEdicao, _lyt.tNumeroEdicao,
                          _lyt.fEdicao, _lyt.fEditora, _lyt.fNumeroEdicao),
                      Card(
                        margin: const EdgeInsets.only(top: 2, bottom: 3),
                        child:  Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: LivroInput(
                                _lyt.tEditora, 'Insira uma Editora', 'Editora',
                                focus: _lyt.fEditora, focusNext: _lyt.fPaginas)),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 170,
                            height: 260,
                            child: ListView.builder(
                              itemCount: 1,
                              primary: false,
                              padding: const EdgeInsets.all(0.5),
                              itemBuilder: (BuildContext context, int index) {
                                novoLivro ??= Livro();

                                if (images[index] is ImageUploadModel) {
                                  ImageUploadModel? uploadModel = images[index] as ImageUploadModel?;

                                  novoLivro ??= Livro();

                                  novoLivro?.link = link ?? '/images/image.png';

                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: <Widget>[
                                        Image.file(
                                          File(uploadModel?.imageFile?.path ?? ''),
                                          width: 300,
                                          height: 300,
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: InkWell(
                                            child: const Icon(
                                              Icons.remove_circle,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                images.replaceRange(
                                                    index, index + 1, ['Add Image']);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  if (index == 0 && novoLivro?.link != null) {
                                    return InkWell(
                                        onTap: () {
                                          _onAddImageClick(index);
                                        },
                                        child: LivroImage(novoLivro));
                                  } else {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            width: 250,
                                            height: 200,
                                            child: Card(
                                              margin: EdgeInsets.zero,
                                              child: IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  _onAddImageClick(index);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          // Container(
                          //   width: 170,
                          //   height: 260,
                          //   child: StaggeredGridView.countBuilder(
                          //     crossAxisCount: 2,
                          //     itemCount: 1,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       if (novoLivro == null) novoLivro = Livro();
                          //
                          //       if (images[index] is ImageUploadModel) {
                          //         ImageUploadModel uploadModel = images[index];
                          //
                          //         if (novoLivro == null) novoLivro = Livro();
                          //
                          //         novoLivro.link = link ?? '/images/image.png';
                          //
                          //         return Container(
                          //           child: Card(
                          //             clipBehavior: Clip.antiAlias,
                          //             child: Stack(
                          //               children: <Widget>[
                          //                 Image.file(
                          //                   uploadModel.imageFile,
                          //                   width: 300,
                          //                   height: 300,
                          //                 ),
                          //                 Positioned(
                          //                   right: 5,
                          //                   top: 5,
                          //                   child: InkWell(
                          //                     child: const Icon(
                          //                       Icons.remove_circle,
                          //                       size: 20,
                          //                       color: Colors.red,
                          //                     ),
                          //                     onTap: () {
                          //                       setState(() {
                          //                         images.replaceRange(
                          //                             index, index + 1, ['Add Image']);
                          //                       });
                          //                     },
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         );
                          //       } else {
                          //         if (index == 0 && novoLivro.link != null) {
                          //           return Container(
                          //             child: InkWell(
                          //                 onTap: () {
                          //                   _onAddImageClick(index);
                          //                 },
                          //                 child: LivroImage(novoLivro)),
                          //           );
                          //         } else {
                          //           return Column(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: <Widget>[
                          //               Expanded(
                          //                 child: Container(
                          //                   width: 250,
                          //                   height: 200,
                          //                   child: Card(
                          //                     margin: EdgeInsets.zero,
                          //                     child: IconButton(
                          //                       icon: const Icon(Icons.add),
                          //                       onPressed: () {
                          //                         _onAddImageClick(index);
                          //                       },
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           );
                          //         }
                          //       }
                          //     },
                          //     staggeredTileBuilder: (int index) =>
                          //     StaggeredTile.count(2, index.isEven ? 3 : 1.3),
                          //     mainAxisSpacing: 4.0,
                          //     crossAxisSpacing: 4.0,
                          //   ),
                          // ),
                          CadPaginas(
                              _lyt.tNumeroPaginas,
                              _lyt.fPaginas,
                              _lyt.fDescricao,
                              livroObtido,
                              this,
                              _onClickCategoria)
                        ],
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 2, bottom: 3),
                        child:  ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 80.0,
                            maxHeight: 180.0,
                          ),
                          child: LivroInput(_lyt.tDescricao,
                              'Insira uma Descrição', 'Descrição',
                              type: TextInputType.multiline,
                              maxLines: 8,
                              focus: _lyt.fDescricao,
                              action: TextInputAction.none),
                        ),
                      ),
                      StreamBuilder<bool>(
                        initialData: false,
                        stream: _blocISBN.stream,
                        builder: (context, snapshot) {
                          if (snapshot.data == true) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: LivroInput(_lyt.tISBN10, '', 'ISBN',
                                        type: TextInputType.number,
                                        focus: _lyt.fIsbn10,
                                        focusNext: _lyt.fIsbn13,
                                        validar: false),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: LivroInput(
                                      _lyt.tISBN13, '', 'Código de Barras',
                                      type: TextInputType.number,
                                      focus: _lyt.fIsbn13,
                                      focusNext: _lyt.fDataCompra,
                                      validar: false),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      StreamBuilder<bool>(
                        initialData: false,
                        stream: _blocCompra.stream,
                        builder: (context, snapshot) {
                          if (snapshot.data == true) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: LivroInput(
                                        _lyt.tDataCompra, '', 'Data da Compra',
                                        focus: _lyt.fDataCompra,
                                        focusNext: _lyt.fPreco,
                                        validar: false),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: LivroInput(_lyt.tPreco, '', 'Preço',
                                      type: const TextInputType.numberWithOptions(
                                          decimal: true),
                                      focus: _lyt.fPreco,
                                      validar: false),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      StreamBuilder<bool>(
                        stream: _bloc.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                padding: const EdgeInsets.all(16),
                                child: LivroButton("Cadastrar", salvar, showProgress: snapshot.data ?? false,));
                          } else {
                            return ContainerProgress();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ContainerProgress();
            }
          } else {
            return ContainerProgress();
          }
        },
      ),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker().pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    _imageFile.then((file) async {
      if (file == null) {
        toast('Cancelado!');
        images.removeLast();
        return;
      }

      setState(() {
        ImageUploadModel imageUpload = ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        imageUpload.isBanner = index == 0 ? false : true;
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }

  _onClickCategoria(int categoria) {
    this.categoria = categoria;
  }

  salvar() async {
    var validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }

    var livro =
        _extension.obterLivro(novoLivro, _lyt, _lido, categoria, _origem);

    livro.link = link;

    var anoEdicao = int.tryParse(_lyt.tAnoEdicao.text);
    var paginas = int.tryParse(_lyt.tNumeroPaginas.text);

    if (anoEdicao == null) {
      toast('Favor insira um Ano de Edição');
      return;
    }

    if (paginas == null) {
      toast('Favor insira Número de Páginas');
      return;
    }

    _bloc.obterUrl(true);

    for (var image in images) {
      if (image is ImageUploadModel) {
        ImageUploadModel uploadModel = image;

        List<String> lista = await _extension.salvarImagem(
            File(uploadModel.imageFile?.path ?? ''),
            _lyt.tTitulo.text,
            livro);
        //_caminho = lista[0];
        link = lista[1];
        fileP = uploadModel.imageFile;
        imageCache.clear();
      }
    }

    livro.link = link;

    if (livroObtido != null && livroObtido?.id != null) {
      livro.id = livroObtido?.id;
      livro.firebaseCodigo = livroObtido?.firebaseCodigo;
      livro.dataHoraCriacao = livroObtido?.dataHoraCriacao;
    }

    var id = await _extension.salvar(context, livro);

    if (id == -1) {
      _bloc.obterUrl(false);
      return;
    }

    livro.id = id;

    bool salvou = false;

    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    var obtido = await livroDAO.obterUltimoRegistro();

    if (livroObtido != null && livroObtido?.id != null) {
      livro.id = livroObtido?.id;
    } else {
      livro.id = obtido?.id;
    }

    salvou = await livroDAO.salvar(livro);
    toast(salvou ? 'Livro salvo!' : 'Falha ao salvar o livro no sqlite!');

    cadastro = true;
    _bloc.obterUrl(false);
    pop(context);
    _blocSincronizacao.sincronizacao(context);
    _blocL.obterLivros();
  }

  @override
  void onSelected<T>(T valor) {
    _origem = valor as PaisOrigem;
  }

  pesquisar() async {
    Item? item = await push(context, PesquisaLivrosPage());

    if (item != null) {
      info = item.volumeinfo;
      _lyt.preencherCamposComLivroPesquisa(item.volumeinfo, _bloc);

      try {
        link = item.volumeinfo?.image?.thumb;
        _bloc.obterUrl(true);
        pesquisa = true;
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }
}

class ImageUploadModel {
  bool? isUploaded;
  bool? uploading;
  XFile? imageFile;
  String? imageUrl;
  bool? isBanner;
  int? id;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
    this.isBanner,
    this.id
  });
}
//501