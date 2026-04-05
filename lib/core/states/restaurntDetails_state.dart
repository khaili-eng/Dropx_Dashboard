abstract class RestaurantDetailsState {}

class RestaurantDetailsInitial extends RestaurantDetailsState {}

class RestaurantDetailsLoading extends RestaurantDetailsState {}

class RestaurantDetailsLoaded extends RestaurantDetailsState {
  final Map<String, dynamic> data;
  RestaurantDetailsLoaded(this.data);
}

class RestaurantUpdateSuccess extends RestaurantDetailsState {
  final String message;
  RestaurantUpdateSuccess(this.message);
}

class RestaurantPasswordResetSuccess extends RestaurantDetailsState {}

class RestaurantDetailsError extends RestaurantDetailsState {
  final String message;
  RestaurantDetailsError(this.message);
}
