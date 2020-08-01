import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:in8/data/repositories/conversao_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'conversao_event.dart';
part 'conversao_state.dart';

class ConversaoBloc extends Bloc<ConversaoEvent, ConversaoState> {
  final ConversaoRepository conversaoRepository;

  ConversaoBloc({@required this.conversaoRepository});

  @override
  Stream<ConversaoState> mapEventToState(
    ConversaoEvent event,
  ) async* {
    if (event is ConversaoFetch) {
      yield ConversaoLoading();
      try {
        final conversoes = await conversaoRepository.getMoedas(event.moedaBase);
        yield ConversaoLoaded(conversoes: conversoes);
      } catch (err) {
        yield ConversaoError();
      }
    }
  }

  @override
  // TODO: implement initialState
  ConversaoState get initialState => ConversaoInitial();
}
