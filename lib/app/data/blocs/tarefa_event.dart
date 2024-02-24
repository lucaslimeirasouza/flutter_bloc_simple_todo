import 'package:flutter_bloc_simple_todo/app/data/models/tarefa_model.dart';

abstract class TarefaEvent {}

class GetTarefas extends TarefaEvent {}

class PostTarefas extends TarefaEvent {
  final TarefaModel tarefa;

  PostTarefas({required this.tarefa});
}

class DeleteTarefas extends TarefaEvent {
  final TarefaModel tarefa;

  DeleteTarefas({required this.tarefa});
}
