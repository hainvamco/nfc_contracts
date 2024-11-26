part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final String name;
  const RegisterState({required this.name});

  @override
  List<Object> get props => [name];

  RegisterState copyWith({String? name}) {
    return RegisterState(name: name ?? this.name);
  }
}
