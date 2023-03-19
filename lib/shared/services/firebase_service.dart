import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';

class FirebaseService {
  obterLivros() => _livros.snapshots();

  CollectionReference get _livros => FirebaseFirestore.instance.collection("livros_m");

  obterProdutos() => _produtos.get();

  CollectionReference get _produtos => FirebaseFirestore.instance.collection("livros_m");

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List<Livro> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
  //   return snapshot.data.docs
  //       .map((document) => Livro.fromJson(document.data()) )
  //       .toList();
  // }

  Future<bool> salvar(Livro livro) async {
    DocumentReference document;

    if (livro.firebaseCodigo != null && livro.firebaseCodigo?.isNotEmpty == true) {
      document = _livros.doc(livro.firebaseCodigo);
    } else {
      document = _livros.doc();
    }

    DocumentSnapshot documentSnapshot = await document.get();

    print('Document inicio = ${document.id}');
    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    livro.firebaseCodigo = document.id;

    if (documentSnapshot.exists) {
      document.update(livro.toMap());
      print('Document Atualizado = ${document.id}');
      await livroDAO.salvar(livro);
      return true;
    } else {
      var id  = await livroDAO.inserirEObterId(livro);
      livro.id = id;
      document.set(livro.toMap());
      print('Document Salvo = ${document.id}');

      return true;
    }
  }

  Future<bool> excluir(Livro livro) async {
    DocumentReference document = _livros.doc(livro.firebaseCodigo);
    DocumentSnapshot documentSnapshot = await document.get();

    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    livro.firebaseCodigo = document.id;

    if (documentSnapshot.exists) {
      document.delete();
      print('Document Atualizado = ${document.id}');
      await livroDAO.deletar(livro.id);
      return true;
    }
    return false;
  }

  Future<Response> login(String email, String senha) async {
    try {
      var fUser = await _auth.signInWithEmailAndPassword(email: email, password: senha);
      print("Usuario Logado: ${fUser.user?.displayName}");
      print('Id ${fUser.user?.uid}');

      return Response(true,"Login efetuado com sucesso");
    } catch(error) {
      print(error);

      if(error is PlatformException) {
        print("Error Code ${error.code}");

        return Response(false,"Email/Senha incorretos\n\n${error.message}");
      }

      return Response(false,"Não foi possível fazer o login");
    }
  }
}

class Response {
  final bool ok;
  final String msg;
  String url = '';

  Response(this.ok, this.msg);

  Response.fromJson(Map<String,dynamic> map) :
        ok = map["status"] == "OK",
        msg = map["msg"],
        url = map["url"];

  bool isOk() {
    return ok;
  }
}