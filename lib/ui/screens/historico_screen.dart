import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:in8/data/models/conversao_historico.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoricoScreen extends StatefulWidget {
  @override
  _HistoricoScreenState createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<ConversaoHistorico> _historico = [];
  List<ConversaoHistorico> _historicoFiltrado = [];
  bool _loadingHistorico = true;
  bool _filtroAtivo = false;

  final TextEditingController _filter = new TextEditingController();
  // String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Histórico');

  @override
  void initState() {
    _buscarHistorico();
    // TODO: implement initState
    super.initState();
  }

  _buscarHistorico() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _historico = prefs
          .getStringList("historico")
          .map((hist) =>
              ConversaoHistorico.fromConversaoHistoricoJson(json.decode(hist)))
          .toList(); // Salvando 'em cache'
      this._loadingHistorico = false;
      this._historicoFiltrado =
          this._historico; // Passando para variável que irá exibir na tela
    });

    _filter.addListener(() {
      if (_filter.text.isNotEmpty) {
        setState(() {
          this._historicoFiltrado = _search(_filter.text);
        });
      }
    });
  }

  List<ConversaoHistorico> _search(String search) {
    List<ConversaoHistorico> _historicoFilter = [];
    _historico.forEach((element) {
      if (element.moedaEntrada.toLowerCase().contains(search) ||
          element.moedaSaida.toLowerCase().contains(search) ||
          element.valorEntrada.toLowerCase().contains(search) ||
          element.valorSaida.toLowerCase().contains(search)) {
        _historicoFilter.add(element);
      }
    });
    return _historicoFilter;
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Pesquisa'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Histórico');
        this._historicoFiltrado = this._historico;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
          ),
        ],
      ),
      body: Container(
        child: _loadingHistorico
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Entrada: ${_historicoFiltrado[index].valorEntrada} ' +
                        '${_historicoFiltrado[index].moedaEntrada}'),
                    subtitle: Text('Saída: ${_historicoFiltrado[index].valorSaida} ' +
                        '${_historicoFiltrado[index].moedaSaida}'),
                  );
                },
                itemCount: _historicoFiltrado.length,
              ),
      ),
    );
  }
}
