

class AdminFeesState {
  final double? driverMonthly;
  final double? driverDaily;
  final double? restaurantMonthly;
  final double? restaurantDaily;

  final bool loading;

  final String? error;

  AdminFeesState({
    this.driverMonthly,
    this.driverDaily,
    this.restaurantMonthly,
    this.restaurantDaily,
    this.loading = false,
    this.error,
  });

  AdminFeesState copyWith({
    double? driverMonthly,
    double? driverDaily,
    double? restaurantMonthly,
    double? restaurantDaily,
    bool? loading,
    String? error,
  }) {
    return AdminFeesState(
      driverMonthly: driverMonthly ?? this.driverMonthly,
      driverDaily: driverDaily ?? this.driverDaily,
      restaurantMonthly: restaurantMonthly ?? this.restaurantMonthly,
      restaurantDaily: restaurantDaily ?? this.restaurantDaily,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}