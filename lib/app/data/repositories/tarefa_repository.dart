import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_simple_todo/app/data/models/tarefa_model.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<List<TarefaModel>> getTarefas() async {
    _tarefas.addAll([
      TarefaModel(nome: 'Compras'),
      TarefaModel(nome: 'Academia'),
      TarefaModel(nome: 'Escola'),
      TarefaModel(nome: 'Lazer'),
    ]);

    return Future.delayed(const Duration(seconds: 2), () => _tarefas);
  }

  Future<List<TarefaModel>> postTarefas({required TarefaModel tarefa}) async {
    _tarefas.add(tarefa);

    return Future.delayed(const Duration(seconds: 2), () => _tarefas);
  }

  Future<List<TarefaModel>> deleteTarefas({required TarefaModel tarefa}) async {
    _tarefas.remove(tarefa);

    return Future.delayed(const Duration(seconds: 2), () => _tarefas);
  }
}
