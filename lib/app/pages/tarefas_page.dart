import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_todo/app/data/blocs/tarefa_bloc.dart';
import 'package:flutter_bloc_simple_todo/app/data/blocs/tarefa_event.dart';
import 'package:flutter_bloc_simple_todo/app/data/blocs/tarefa_state.dart';
import 'package:flutter_bloc_simple_todo/app/data/models/tarefa_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TarefaBloc _tarefaBloc;
  @override
  void initState() {
    super.initState();
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.add(GetTarefas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<TarefaBloc, TarefaState>(
          bloc: _tarefaBloc,
          builder: (context, state) {
            if (state is TarefaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TarefaLoadedState) {
              final list = state.tarefas;
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Center(
                        child: Text(list[index].nome[0]),
                      ),
                    ),
                    title: Text(list[index].nome),
                    trailing: IconButton(
                      onPressed: () {
                        _tarefaBloc.add(
                          DeleteTarefas(
                            tarefa: list[index],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _tarefaBloc.add(PostTarefas(tarefa: TarefaModel(nome: 'teste')));
        },
      ),
    );
  }

  @override
  void dispose() {
    _tarefaBloc.close();
    super.dispose();
  }
}
