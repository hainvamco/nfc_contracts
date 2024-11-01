import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState(count: 0)) {
    emit(state.copyWith(count: 1));
  }

  increateCount() {
    emit(
      state.copyWith(count: state.count + 1),
    );
  }
}
