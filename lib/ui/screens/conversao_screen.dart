import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:in8/data/bloc/conversao_bloc/conversao_bloc.dart';
import 'package:in8/data/models/conversao_historico.dart';
import 'package:in8/ui/screens/historico_screen.dart';
import 'package:in8/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversaoScreen extends StatefulWidget {
  @override
  _ConversaoScreenState createState() => _ConversaoScreenState();
}

class _ConversaoScreenState extends State<ConversaoScreen> {
  final moneyController = new MoneyMaskedTextController();
  final resultadoController = new MoneyMaskedTextController();
  String moedaEntrada = "BRL";
  String moedaSaida = "USD";
  bool ocultarResposta = true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ConversaoBloc conversaoBloc;

  final List<String> moedas = [
    "CAD",
    "HKD",
    "ISK",
    "PHP",
    "DKK",
    "HUF",
    "CZK",
    "GBP",
    "RON",
    "SEK",
    "IDR",
    "INR",
    "BRL",
    "RUB",
    "HRK",
    "JPY",
    "THB",
    "CHF",
    "EUR",
    "MYR",
    "BGN",
    "TRY",
    "CNY",
    "NOK",
    "NZD",
    "ZAR",
    "USD",
    "MXN",
    "SGD",
    "AUD",
    "ILS",
    "KRW",
    "PLN"
  ];

  _logout() {
    Navigator.pushReplacement(context,
        MaterialPageRoute<void>(builder: (context) {
      return LoginScreen();
    }));
  }

  _visualizarHistorico() {
    Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
      return HistoricoScreen();
    }));
  }

  _downloadTabelaConversao() {
    conversaoBloc.add(ConversaoFetch(moedaBase: moedaEntrada));
    this.ocultarResposta = false;
  }

  _converterMoeda(conversoes) {
    double resultado =
        moneyController.numberValue * conversoes['rates'][moedaSaida];
    resultadoController.updateValue(resultado);
    this._salvarHistorico();
  }

  _salvarHistorico() async {
    final SharedPreferences prefs = await _prefs;
    var historicoSalvo = prefs.getStringList("historico") ?? [];
    var historico = ConversaoHistorico.fromConversaoHistoricoJson({
      'moedaEntrada': moedaEntrada,
      'moedaSaida': moedaSaida,
      'valorEntrada': moneyController.numberValue.toString(),
      'valorSaida': resultadoController.numberValue.toString()
    });
    historicoSalvo.add(json.encode(historico.toJson()));

    prefs.setStringList("historico", historicoSalvo);
  }

  @override
  void initState() {
    conversaoBloc = BlocProvider.of<ConversaoBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conversão de Moeda",
        ),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _visualizarHistorico();
            },
            child: Text(
              "Histórico",
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              })
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        },
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    width: width,
                    child: DropdownButton(
                      isExpanded: true,
                      hint: new Text("TIPO MOEDA"),
                      value: moedaEntrada,
                      // elevation: 16,
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      style: TextStyle(color: Colors.green),
                      items:
                          moedas.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (str) {
                        setState(() {
                          moedaEntrada = str;
                        });
                        // Após qualquer mudança, limpa o resultado, para evitar que o setState recalcule automaticamente o valor final, já que a tabela de conversão já foi baixada
                        resultadoController.updateValue(0);
                        this.ocultarResposta = true;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextField(
                      controller: moneyController,
                      onChanged: (str) {
                        this.ocultarResposta = true;
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(hintText: "Valor"),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    width: width,
                    child: DropdownButton(
                      isExpanded: true,
                      hint: new Text("MOEDA DESEJADA"),
                      value: moedaSaida,
                      // elevation: 16,
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      style: TextStyle(color: Colors.green),
                      items:
                          moedas.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (str) {
                        setState(() {
                          moedaSaida = str;
                        });
                        // Após qualquer mudança, limpa o resultado, para evitar que o setState recalcule automaticamente o valor final, já que a tabela de conversão já foi baixada
                        resultadoController.updateValue(0);
                        this.ocultarResposta = true;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      width: width,
                      height: 45,
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.purple),
                          onPressed: () {
                            if (moneyController.numberValue.compareTo(0) != 0)
                              _downloadTabelaConversao();
                          },
                          child: Text(
                            "CONVERTER",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.purple,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: BlocBuilder(
                        bloc: conversaoBloc,
                        builder: (context, state) {
                          if (state is ConversaoInitial ||
                              this.ocultarResposta) {
                            return Container();
                          }
                          if (state is ConversaoLoading) {
                            return Container(
                              child: LinearProgressIndicator(),
                            );
                          }
                          if (state is ConversaoLoaded &&
                              !this.ocultarResposta) {
                            _converterMoeda(state.conversoes);
                            return TextField(
                              enabled: false,
                              controller: resultadoController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: InputDecoration(
                                hintText: "Resultado",
                              ),
                            );
                          }
                          if (state is ConversaoError) {
                            return Text(
                              "Falha na requisição",
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
          // child: Column(
          //   children: <Widget>[
          //     Expanded(
          //       flex: 1,
          //       child: Column(
          //         children: <Widget>[

          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
