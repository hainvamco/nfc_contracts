import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState(count: 0, firebaseToken: '', isLoading: false)) {
    emit(state.copyWith(count: 1));
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  increateCount() {
    print('---increate by open app link');
    emit(
      state.copyWith(count: state.count + 1),
    );
  }
}
