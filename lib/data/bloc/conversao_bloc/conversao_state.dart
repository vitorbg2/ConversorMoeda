part of 'conversao_bloc.dart';

@immutable
abstract class ConversaoState extends Equatable {}

class ConversaoInitial extends ConversaoState {
  @override
  List<Object> get props => [];
}

class ConversaoLoading extends ConversaoState {
  @override
  List<Object> get props => [];
}

class ConversaoLoaded extends ConversaoState {
  final dynamic conversoes;

  ConversaoLoaded({@required this.conversoes});

  @override
  List<Object> get props => [];
}

class ConversaoError extends ConversaoState {
  @override
  List<Object> get props => [];
}
