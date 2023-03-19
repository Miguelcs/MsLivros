import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:livros/shared/services/model/volume_json.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/ui/pages/livros/pages/livros_page.dart';
import 'package:livros/ui/widgets/app_text_field.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class PesquisaLivrosPage extends StatefulWidget {
  const PesquisaLivrosPage({super.key});

  @override
  _PesquisaLivrosPageState createState() => _PesquisaLivrosPageState();
}

class _PesquisaLivrosPageState extends State<PesquisaLivrosPage> {
  final _tPesquisa = TextEditingController();
  var numerico = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar Livros'),),
      body: Container(
        decoration: DecorationLogo.decoration(),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: MaterialButton(
                          color: numerico ? Colors.blue : Colors.deepOrange,
                          child: const Text('Por Título', style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            _porTitulo();
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: MaterialButton(
                        color: numerico ? Colors.deepOrange : Colors.blue,
                          child: const Text('Por ISBN', style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            _porISBN();
                          }),
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                heroTag: 'Novo',
                child: const Icon(Icons.camera_alt),
                onPressed: barcodeScanning,
              ),
              const SizedBox(),
              AppTextField('Pesquisar', 'Pesquisar',
                  controller: _tPesquisa,
                  keyboardType: numerico ? TextInputType.number : TextInputType.text,),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(30),
                child: MaterialButton(
                    child: const Text('Buscar'),
                    onPressed: () {
                      _buscar();
                    }),
              ),
              FutureBuilder<VolumeJson?>(
                future: obterLivros(_tPesquisa.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(0.5),
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      children: List.generate(
                        snapshot.data?.items?.length ?? 0,
                            (index) {
                          Item? filme = snapshot.data?.items![index];
                          return _containers(filme, context, true);
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(''),
                    );
                  } else {
                    return Center(
                      child: FutureBuilder(
                          future: Future.delayed(const Duration(seconds: 3)),
                          builder: (c, s) => s.connectionState == ConnectionState.done
                              ? Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: const Center(
                              child: Text(
                                'Nenhum Livro Encontrado',
                                style: TextStyle(fontSize: 19.0, color: Colors.white),
                              ),
                            ),
                          )
                              : ContainerProgress()),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buscar() {
    setState(() {

    });
  }

  _containers(Item? filme, BuildContext context, bool grid) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      padding: const EdgeInsets.all(0.5),
      child: Card(
        child: SizedBox(
            height: 560, width: 340, child: _obterImagem(context, filme)),
      ),
    );
  }

  Future<VolumeJson?> obterLivros(String query) async {

    if (_tPesquisa.text.isEmpty) {
      return null;
    }

    debugPrint('Im Starting');


    String pesquisa = 'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=40';
    //String ui.pages.pesquisa = 'https://www.googleapis.com/books/v1/volumes?q=$query';

    if (numerico) {
      pesquisa = 'https://www.googleapis.com/books/v1/volumes?q=isbn:$query';
    }

    final jsonResponse =
    await http.get(Uri.parse(pesquisa));

    var jsonBody = convert.json.decode(jsonResponse.body);
    //print(jsonBody);

    return VolumeJson.fromJson(jsonBody);
  }

  _obterImagem(context, Item? filme) {
    var thumb = filme?.volumeinfo?.image?.thumb ?? '';

    return SizedBox(
      height: 270,
      width: 270,
      child: Hero(
        tag: filme?.etag ?? '',
        child: Card(
            margin: const EdgeInsets.all(0),
            child: InkWell(
                onTap: () {
                  pop(context, filme);
                },
                child: Image.network(thumb.isNotEmpty ? thumb : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjHe6LibnCth5quB4mITGaeRUn0PHsdJaMd1wIqXBBC2HqfSBqoA&s'))
        ),
      ),
    );
  }

  void _porTitulo() {
    numerico = false;
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {

    });
  }

  void _porISBN() {
    numerico = true;
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {

    });
  }

  // Method for scanning barcode....
  Future barcodeScanning() async {
    //imageSelectorGallery();

    // try {
    //   var result = await BarcodeScanner.scan();
    //   String barcode = result.formatNote;
    //   setState(() => this._tPesquisa.text = barcode);
    // } catch (e) {
    //   if (e.code == BarcodeScanner.cameraAccessDenied) {
    //     setState(() {
    //       this._tPesquisa.text = 'No camera permission!';
    //     });
    //   } else {
    //     setState(() => this._tPesquisa.text = 'Unknown error: $e');
    //   }
    // }
  }
}
