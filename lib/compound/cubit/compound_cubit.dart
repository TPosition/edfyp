import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'compound_state.dart';

class CompoundCubit extends Cubit<CompoundState> {
  CompoundCubit({required final List<User> users})
      : _users = users,
        super(const CompoundState());

  final List<User> _users;

  void init() {
    emit(state.copyWith(usersList: _users));
  }

  void uidSearchChanged(final String value) {
    final List<User?> filtered = state.usersList.map((final user) {
      if (user.uid.toLowerCase().contains(value.toLowerCase())) {
        return user;
      }
      return null;
    }).toList();

    emit(state.copyWith(filteredUsersList: filtered));
  }
}
