part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}


class LogOut extends HomeEvent{
  const LogOut();

  @override
  List<Object> get props => [];

}

class GetPasswordsSaved extends HomeEvent{
  const GetPasswordsSaved();

  @override
  List<Object> get props => [];

}

class SearchPassword extends HomeEvent{
  final String searchWord;
  final List<Password> passwordsSaved;

  const SearchPassword({required this.searchWord, required this.passwordsSaved});

  @override
  List<Object> get props => [searchWord];

}