part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final int count;
  final String firebaseToken;
  final bool isLoading;
  
  const SplashState({
    required this.count,
    required this.firebaseToken,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [count, firebaseToken, isLoading];

  SplashState copyWith({
    int? count,
    String? firebaseToken,
    bool? isLoading,
  }) {
    return SplashState(
      count: count ?? this.count,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
