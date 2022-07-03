part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationEmpty extends MovieRecommendationState {}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Film> movie;

  const MovieRecommendationLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  const MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
