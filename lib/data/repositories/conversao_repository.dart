import 'package:in8/data/providers/conversao_provider.dart';
import 'package:meta/meta.dart';

class ConversaoRepository {

  final ConversaoProvider conversaoProvider;

  ConversaoRepository({@required this.conversaoProvider});

  
  Future<dynamic> getMoedas(String moedaBase) async{
    return await conversaoProvider.getConversoes(moedaBase: 'base=' + moedaBase);
  }

}