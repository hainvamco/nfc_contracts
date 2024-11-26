import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController nameController = TextEditingController();
  RegisterCubit() : super(const RegisterState(name: '')) {
    nameController.addListener(() {
      print('---name: ${nameController.text}');
      emit(state.copyWith(name: nameController.text));
    });
  }
}
