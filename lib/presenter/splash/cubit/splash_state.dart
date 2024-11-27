part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final int count;
  final String firebaseToken;
  const SplashState({
    required this.count,
    required this.firebaseToken,
  });

  @override
  List<Object> get props => [count, firebaseToken];

  SplashState copyWith({
    int? count,
    String? firebaseToken,
  }) {
    return SplashState(
      count: count ?? this.count,
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }
}
