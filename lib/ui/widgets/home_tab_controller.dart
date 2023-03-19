import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';
import 'package:livros/ui/pages/home/tabs/lendo_page.dart';
import 'package:livros/ui/pages/home/tabs/lidos_page.dart';
import 'package:livros/ui/pages/home/tabs/nao_lidos_page.dart';
import 'package:livros/ui/pages/home/tabs/todos_page.dart';

class HomeTabController extends StatefulWidget {
  final SincronizacaoBloc _blocSincronizacao;
  final TabController? tabController;
  final AtualizarBloc _bloc;
  final int qtdeNaoLidos;
  final int qtdeTodos;
  final int qtdeLendo;
  final int qtdeLidos;
  final bool grid;

  const HomeTabController(
      this._blocSincronizacao,
      this.tabController,
      this._bloc,
      this.qtdeNaoLidos,
      this.qtdeTodos,
      this.qtdeLendo,
      this.qtdeLidos,
      this.grid, {super.key});

  @override
  State<HomeTabController> createState() => _HomeTabControllerState();
}

class _HomeTabControllerState extends State<HomeTabController> {
  int selectedIdx = 0;

  SincronizacaoBloc get _blocSincronizacao => widget._blocSincronizacao;

  List<BottomNavBarItemData> screens() {
    return [
      BottomNavBarItemData(
          "First Page",
          const Icon(Icons.cake),
          StreamBuilder<Sincroniza>(
            stream: _blocSincronizacao.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Tab(text: "Todos - ${snapshot.data?.qtdeTodos}", icon: const Icon(FontAwesome5.book, size: 20,),);
              }
              return Tab(text: "Todos - ${widget.qtdeTodos}", icon: const Icon(FontAwesome5.book, size: 20,),);
            },
          )
      ),
      BottomNavBarItemData(
        "Seond Page",
        const Icon(Icons.calendar_today),
        StreamBuilder<Sincroniza>(
          stream: widget._blocSincronizacao.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Tab(text: "Lendo - ${snapshot.data?.qtdeLendo}", icon: const Icon(FontAwesome5.book_reader, size: 20,),);
            }
            return Tab(text: "Lendo - ${widget.qtdeLendo}", icon: const Icon(FontAwesome5.book_reader, size: 20,),);
          },
        ),
      ),
      BottomNavBarItemData(
        "Seond Page",
        const Icon(Icons.calendar_today),
        StreamBuilder<Sincroniza>(
          stream: widget._blocSincronizacao.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Tab(text: "Lidos - ${snapshot.data?.qtdeLidos}", icon: const Icon(FontAwesome5.book_open, size: 20,),);
            }
            return Tab(text: "Lidos - ${widget.qtdeLidos}", icon: const Icon(FontAwesome5.book_open, size: 20,),);
          },
        ),
      ),
      BottomNavBarItemData(
        "Seond Page",
        const Icon(Icons.calendar_today),
        StreamBuilder<Sincroniza>(
          stream: widget._blocSincronizacao.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Tab(text: "Não Lidos - ${snapshot.data?.qtdeNaoLidos}", icon: const Icon(FontAwesome.book, size: 20,),);
            }
            return Tab(text: "Não Lidos - ${widget.qtdeNaoLidos}", icon: const Icon(FontAwesome.book,),);
          },
        ),
      ),
    ];
  }

  Widget _buildIcon(String text, IconData icon, String textSize, int index) {
    return Column(
      children: [
        Badge(
          label: Text(textSize),
          child: Icon(icon, size: 20, color: index == selectedIdx ? Color(0xFF002171) : Colors.black45),
          backgroundColor: index == selectedIdx ? Colors.red : Colors.black45,
        ),
        Text(
          text,
          style: TextStyle(color: index == selectedIdx ? Color(0xFF002171) : Colors.black45),
        )
      ],
    );

    return Padding(padding: const EdgeInsets.all(10.0),

      child: Stack(

        children: <Widget>[
          Container(
            height: 150.0,
            width: 30.0,
            child: const IconButton(icon: Icon(Icons.shopping_cart,
              color: Colors.black,),
              onPressed: null,
            ),
          ),
          //list.length ==0 ? Container() :
          Positioned(
              child: Stack(
                children: <Widget>[
                  Icon(
                      Icons.brightness_1,
                      size: 20.0, color: Colors.green[800]),
                  const Positioned(
                      top: 3.0,
                      right: 4.0,
                      child: Center(
                        child: Text(
                          '10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )),


                ],
              )),

        ],
      )
    );


    return SizedBox(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.email_outlined),
          Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF002171), ), textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Sincroniza>(
      stream: widget._blocSincronizacao.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIdx,
              selectedItemColor: const Color(0xFF002171),
              unselectedItemColor: Colors.black45,
              onTap: (idx) => setState(() {
                selectedIdx = idx;
              }),
              items: [
                BottomNavigationBarItem(
                  label: "Todos - ${snapshot.data?.qtdeTodos}",
                  icon: const Icon(FontAwesome.book, size: 20),
                ),
                BottomNavigationBarItem(
                  label: "Lendo - ${snapshot.data?.qtdeLendo}",
                  icon: const Icon(FontAwesome5.book_reader, size: 20),
                ),
                BottomNavigationBarItem(
                  label: "Lidos - ${snapshot.data?.qtdeLidos}",
                  icon: const Icon(FontAwesome5.book_open, size: 20),
                ),
                BottomNavigationBarItem(
                  label: "Não Lidos - ${snapshot.data?.qtdeNaoLidos}",
                  icon: const Icon(FontAwesome.book, size: 20),
                ),
              ]
            ),
            body: IndexedStack(
              index: selectedIdx,
              children: [
                TodosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                LendoPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                LidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                NaoLidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                //...screens.map((e) => e.screen).toList(),
              ],
            ),
          );
        }
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIdx,
              selectedItemColor: const Color(0xFF002171),
              unselectedItemColor: Colors.black45,
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(fontSize: 0, ),
              selectedLabelStyle: const TextStyle(fontSize: 0),

              onTap: (idx) => setState(() {
                selectedIdx = idx;
              }),
              items: [
                BottomNavigationBarItem(
                  label: "",
                  //icon: Icon(FontAwesome.book, size: 20),
                  //icon: _buildIcon("Todos\n${widget.qtdeTodos}"),
                  icon: _buildIcon('Todos', FontAwesome.book, '${widget.qtdeTodos}', 0),
                ),
                BottomNavigationBarItem(
                  label: "",
                  //icon: const Icon(FontAwesome5.book_reader, size: 20),
                  icon: _buildIcon('Lendo', FontAwesome5.book_reader, '${widget.qtdeLendo}', 1),
                ),
                BottomNavigationBarItem(
                  label: "",
                  //icon: const Icon(FontAwesome5.book_open, size: 20),
                  icon: _buildIcon('"Lidos', FontAwesome5.book_open, '${widget.qtdeLidos}', 2),
                ),
                BottomNavigationBarItem(
                  label: "",
                  //icon: const Icon(FontAwesome.book, size: 20),
                  icon: _buildIcon('Não Lidos', FontAwesome.book, '${widget.qtdeNaoLidos}', 3),
                ),
              ]
          ),
          body: IndexedStack(
            index: selectedIdx,
            children: [
              TodosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
              LendoPage(widget._blocSincronizacao, widget._bloc, widget.grid),
              LidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
              NaoLidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
              //...screens.map((e) => e.screen).toList(),
            ],
          ),
        );
      },
    );

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIdx,
        selectedItemColor: const Color(0xFF002171),
        unselectedItemColor: Colors.black45,
        onTap: (idx) => setState(() {
          selectedIdx = idx;
        }),
        items: screens()
            .map(
              (e) => BottomNavigationBarItem(
            label: e.label,
            icon: e.icon,
          ),
        )
            .toList(),
      ),
      body: IndexedStack(
        index: selectedIdx,
        children: [
          TodosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
          LendoPage(widget._blocSincronizacao, widget._bloc, widget.grid),
          LidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
          NaoLidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
          //...screens.map((e) => e.screen).toList(),
        ],
      ),
    );

    return DefaultTabController(
      length: 4,
      child: Container(
        color: const Color(0xFF002171),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TabBar(
              controller: widget.tabController,
              isScrollable: true,
              tabs: [
                StreamBuilder<Sincroniza>(
                  stream: widget._blocSincronizacao.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Tab(text: "Todos - ${snapshot.data?.qtdeTodos}", icon: const Icon(FontAwesome5.book, size: 20,),);
                    }
                    return Tab(text: "Todos - ${widget.qtdeTodos}", icon: const Icon(FontAwesome5.book, size: 20,),);
                  },
                ),
                StreamBuilder<Sincroniza>(
                  stream: widget._blocSincronizacao.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Tab(text: "Lendo - ${snapshot.data?.qtdeLendo}", icon: const Icon(FontAwesome5.book_reader, size: 20,),);
                    }
                    return Tab(text: "Lendo - ${widget.qtdeLendo}", icon: const Icon(FontAwesome5.book_reader, size: 20,),);
                  },
                ),
                StreamBuilder<Sincroniza>(
                  stream: widget._blocSincronizacao.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Tab(text: "Lidos - ${snapshot.data?.qtdeLidos}", icon: const Icon(FontAwesome5.book_open, size: 20,),);
                    }
                    return Tab(text: "Lidos - ${widget.qtdeLidos}", icon: const Icon(FontAwesome5.book_open, size: 20,),);
                  },
                ),
                StreamBuilder<Sincroniza>(
                  stream: widget._blocSincronizacao.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Tab(text: "Não Lidos - ${snapshot.data?.qtdeNaoLidos}", icon: const Icon(FontAwesome.book, size: 20,),);
                    }
                    return Tab(text: "Não Lidos - ${widget.qtdeNaoLidos}", icon: const Icon(FontAwesome.book,),);
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: widget.tabController,
                children: [
                  TodosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                  LendoPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                  LidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                  NaoLidosPage(widget._blocSincronizacao, widget._bloc, widget.grid),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarItemData {
  final String label;
  final Icon icon;
  final Widget screen;

  BottomNavBarItemData(
      this.label,
      this.icon,
      this.screen,
      );
}