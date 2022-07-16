part of 'compound_cubit.dart';

class CompoundState extends Equatable {
  const CompoundState({
    final this.usersList = const [],
    final this.filteredUsersList = const [],
    final this.uidSearch = '',
  });

  final List<User> usersList;
  final List<User?> filteredUsersList;
  final String uidSearch;

  @override
  List<Object> get props => [usersList, filteredUsersList, uidSearch];

  CompoundState copyWith({
    final List<User>? usersList,
    final List<User?>? filteredUsersList,
    final String? uidSearch,
  }) =>
      CompoundState(
        usersList: usersList ?? this.usersList,
        filteredUsersList: filteredUsersList ?? this.filteredUsersList,
        uidSearch: uidSearch ?? this.uidSearch,
      );
}
