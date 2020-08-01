part of 'conversao_bloc.dart';

@immutable
abstract class ConversaoEvent extends Equatable {}

class ConversaoFetch extends ConversaoEvent {
  final String moedaBase;

  ConversaoFetch({@required this.moedaBase});

  @override
  List<Object> get props => [];
}
