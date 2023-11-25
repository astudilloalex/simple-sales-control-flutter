class CustomerState {
  const CustomerState({
    this.loading = false,
  });

  final bool loading;

  CustomerState copyWith({
    bool? loading,
  }) {
    return CustomerState(
      loading: loading ?? this.loading,
    );
  }
}
