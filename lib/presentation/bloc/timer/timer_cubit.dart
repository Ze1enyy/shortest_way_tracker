import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.dart';
part 'timer_cubit.freezed.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState.initial(percentage: 0));

  Timer? _timer;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (state.percentage < 100) {
        emit(TimerState.initial(percentage: state.percentage + 1));
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
