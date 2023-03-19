import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
//import 'package:flutter_advanced_networkimage/transition.dart';

class LivroFotoLink extends StatelessWidget {
  final Livro livro;

  const LivroFotoLink(this.livro);

  @override
  Widget build(BuildContext context) {
    var link = livro.link;

    if (link == null || link.isEmpty) {
      link = '/images/fundo.png';
    }

    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loader.gif',
      placeholderScale: 0.3,
      image: link,
    );

    // return TransitionToImage(
    //   placeholder: Center(child: CircularProgressIndicator()),
    //   duration: Duration(milliseconds: 300),
    //   image: AdvancedNetworkImage(
    //     '$link',
    //     useDiskCache: true,
    //     cacheRule: CacheRule(maxAge: const Duration(days: 100)),
    //   ),
    //   fit: BoxFit.fill,
    // );
  }
}
