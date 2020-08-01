class ConversaoHistorico {
  final String moedaEntrada;
  final String moedaSaida;
  final String valorEntrada;
  final String valorSaida;

  ConversaoHistorico(
      {this.moedaEntrada, this.moedaSaida, this.valorEntrada, this.valorSaida});

  static ConversaoHistorico fromConversaoHistoricoJson(dynamic json) {
    return ConversaoHistorico(
      moedaEntrada: json['moedaEntrada'],
      moedaSaida: json['moedaSaida'],
      valorEntrada: json['valorEntrada'],
      valorSaida: json['valorSaida'],
    );
  }

  Map<String, dynamic> toJson() => {
        'moedaEntrada': moedaEntrada,
        'moedaSaida': moedaSaida,
        'valorEntrada': valorEntrada,
        'valorSaida': valorSaida
      };
}
