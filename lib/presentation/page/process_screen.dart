import 'package:best_way_tracker/di.dart';
import 'package:best_way_tracker/presentation/bloc/path/path_cubit.dart';
import 'package:best_way_tracker/presentation/bloc/result/results_cubit.dart';
import 'package:best_way_tracker/presentation/bloc/task/task_cubit.dart';
import 'package:best_way_tracker/presentation/bloc/timer/timer_cubit.dart';
import 'package:best_way_tracker/presentation/page/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({
    required this.url,
    super.key,
  });
  final String url;
  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  final _taskCubit = sl<TaskCubit>();
  final _pathCubit = sl<ShortestWayCubit>();
  final _resultsCubit = sl<ResultsCubit>();
  final _timerCubit = sl<TimerCubit>();
  String get url => widget.url;
  bool _isButtonActive = true;

  @override
  void dispose() {
    _timerCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _taskCubit.fetchTasks(url);
    _resultsCubit.stream.listen((state) {
      state.whenOrNull(
        error: (err) {
          _isButtonActive = true;
        },
        loading: () {
          _isButtonActive = false;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<TaskCubit, TaskState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (tasks) {
                    _timerCubit.start();
                    _pathCubit.findShortestWay(tasks: tasks);
                  },
                );
              },
              bloc: _taskCubit,
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (tasks) {
                    return BlocBuilder<ShortestWayCubit, ShortestWayState>(
                      bloc: _pathCubit,
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loaded: (solutions) {
                            return Center(
                              child: Column(
                                children: [
                                  BlocBuilder<TimerCubit, TimerState>(
                                    bloc: _timerCubit,
                                    builder: (context, state) {
                                      return state.when(
                                        initial: (percentage) {
                                          return Column(
                                            children: [
                                              CircularProgressIndicator(
                                                value: percentage / 100,
                                              ),
                                              Text('$percentage%'),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  BlocBuilder<TimerCubit, TimerState>(
                                    bloc: _timerCubit,
                                    builder: (context, state) {
                                      return state.when(
                                        initial: (percentage) {
                                          return percentage == 100
                                              ? TextButton(
                                                  onPressed: _isButtonActive
                                                      ? () {
                                                          _resultsCubit
                                                              .sendAnswer(
                                                            solutions,
                                                            url,
                                                          );
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute<
                                                                ResultsScreen>(
                                                              builder: (context) =>
                                                                  const ResultsScreen(),
                                                            ),
                                                          );
                                                        }
                                                      : null,
                                                  child: const Text(
                                                    'Send results to server',
                                                  ),
                                                )
                                              : const SizedBox.shrink();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: Text.new,
                        );
                      },
                    );
                  },
                  error: (error) => Text(error.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
