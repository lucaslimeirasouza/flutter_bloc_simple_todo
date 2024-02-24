import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_todo/app/data/blocs/tarefa_event.dart';
import 'package:flutter_bloc_simple_todo/app/data/blocs/tarefa_state.dart';
import 'package:flutter_bloc_simple_todo/app/data/models/tarefa_model.dart';
import 'package:flutter_bloc_simple_todo/app/data/repositories/tarefa_repository.dart';

class TarefaBloc extends Bloc<TarefaEvent, TarefaState> {
  final _repository = TarefaRepository();

  TarefaBloc() : super(TarefaInicialState()) {
    on((event, emit) => null);
  }

  void _mapEventToState(TarefaEvent event, Emitter emit) async {
    List<TarefaModel> tarefas = [];

    emit(TarefaLoadingState());

    if (event is GetTarefas) {
      tarefas = await _repository.getTarefas();
    } else if (event is PostTarefas) {
      tarefas = await _repository.postTarefas(tarefa: event.tarefa);
    } else if (event is DeleteTarefas) {
      tarefas = await _repository.deleteTarefas(tarefa: event.tarefa);
    }

    emit(TarefaLoadedState(tarefas: tarefas));
  }
}
