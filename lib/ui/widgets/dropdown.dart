import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/drop_down_bloc.dart';
import 'package:livros/shared/interfaces/on_select_listener.dart';
import 'package:livros/ui/widgets/container_progress.dart';

abstract class DropDownItem {
  String text();
}

class DropDownItens<T extends DropDownItem> extends StatefulWidget {
  List<T> itens = [];
  final T value;
  final OnSelectedListener _listener;
  final String titulo;

  DropDownItens(this.itens, this._listener, this.titulo, {super.key, required this.value});

  @override
  DropDownItensState createState() {
    return DropDownItensState();
  }
}

class DropDownItensState<T extends DropDownItem> extends State<DropDownItens> {
  List<DropDownItem> get itens => widget.itens;
  T? item;

  OnSelectedListener get listener => widget._listener;

  String get titulo => widget.titulo;
  final _bloc = BlocProvider.getBloc<DropDownBloc>();

  @override
  Widget build(BuildContext context) {
    if (item == null && itens != null && itens.length > 0) {
      item = itens[0] as T?;
      _bloc.obter(item);
      listener.onSelected<T>(item!);
    }

    if(widget.value != null) {
      item = widget.value as T?;
      _bloc.obter(item);
      listener.onSelected<T>(item!);
    }

    return Container(
      padding: const EdgeInsets.only(left: 0, top: 10.0, bottom: 10.0),
      //color: Color(Cor.backgroundLight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder<T>(
            //initialData: item,
            stream: _bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$titulo:',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        child: DropdownButton<T>(
                          //value: item,
                          items: items(),
                          isExpanded: true,
                          onChanged: (newVal) {
                            item = newVal;
                            _bloc.obter(newVal);
                            listener.onSelected<T>(newVal!);
                          },
                          hint: Text(
                            //item != null ? '${item.text()}' : '',
                           '${snapshot.data?.text()}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ContainerProgress();
              }
            },
          ),
        ],
      ),
    );
  }

  items() {
    if (item == null && itens != null && itens.length > 0) {
      item = itens[0] as T?;
      _bloc.obter(item);
    }

    if (item == null || itens == null && itens.length < 0) {
      return [
        DropdownMenuItem<T>(
          value: item,
          child: const Text(
            "",
            style: TextStyle(fontSize: 18, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ];
    }

    List<DropdownMenuItem<DropDownItem>> list = widget.itens.map<DropdownMenuItem<DropDownItem>>(
      (val) {
        return DropdownMenuItem<DropDownItem>(
          value: val,
          child: Text(
            val.text(),
            style: const TextStyle(fontSize: 18, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    ).toList();

    return list;
  }
}
