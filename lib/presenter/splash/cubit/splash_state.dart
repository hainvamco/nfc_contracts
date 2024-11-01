part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final int count;
  const SplashState({required this.count});

  @override
  List<Object> get props => [count];

  SplashState copyWith({
    int? count,
  }) {
    return SplashState(
      count: count ?? this.count,
    );
  }
}
