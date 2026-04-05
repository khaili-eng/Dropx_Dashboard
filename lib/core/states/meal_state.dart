abstract class MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealSuccess extends MealState {
  final String message;
  MealSuccess(this.message);
}

class MealError extends MealState {
  final String error;
  MealError(this.error);
}
