import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class AppNetworkImage extends StatelessWidget {
  final String _url;

  const AppNetworkImage(this._url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: CachedNetworkImage(
        imageUrl: _url,
        fit: BoxFit.cover,
        placeholder: (context, url) => ContainerProgress(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
