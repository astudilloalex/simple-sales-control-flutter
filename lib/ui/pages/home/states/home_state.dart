class HomeState {
  const HomeState({
    this.companyId = '',
    this.loading = false,
    this.loadingError = '',
  });

  final String companyId;
  final String loadingError;
  final bool loading;

  HomeState copyWith({
    String? companyId,
    String? loadingError,
    bool? loading,
  }) {
    return HomeState(
      companyId: companyId ?? this.companyId,
      loading: loading ?? this.loading,
      loadingError: loadingError ?? this.loadingError,
    );
  }
}
