part of 'users_admin_cubit.dart';

class UserAdminState extends Equatable {
  const UserAdminState({
    final this.usersList = const [],
    final this.filteredUsersList = const [],
    final this.uidSearch = '',
  });

  final List<User> usersList;
  final List<User?> filteredUsersList;
  final String uidSearch;

  @override
  List<Object> get props => [usersList, filteredUsersList, uidSearch];

  UserAdminState copyWith({
    final List<User>? usersList,
    final List<User?>? filteredUsersList,
    final String? uidSearch,
  }) =>
      UserAdminState(
        usersList: usersList ?? this.usersList,
        filteredUsersList: filteredUsersList ?? this.filteredUsersList,
        uidSearch: uidSearch ?? this.uidSearch,
      );
}
