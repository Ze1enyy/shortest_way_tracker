import 'package:best_way_tracker/di.dart';
import 'package:best_way_tracker/presentation/bloc/result/results_cubit.dart';
import 'package:best_way_tracker/presentation/page/grid_screen.dart';
import 'package:best_way_tracker/utils/field_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final _resultsCubit = sl<ResultsCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results screen'),
      ),
      body: BlocBuilder<ResultsCubit, ResultsState>(
        bloc: _resultsCubit,
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (solutions) {
              return ListView(
                children: solutions
                    .map(
                      (solution) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<GridScreen>(
                              builder: (context) {
                                return GridScreen(
                                  taskId: solution.taskId,
                                  path: solution.path,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Text(
                            FieldParser.stringify(solution.path),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            error: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
