import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'users_admin_state.dart';

class UserAdminCubit extends Cubit<UserAdminState> {
  UserAdminCubit({required final List<User> users, required final String uid})
      : _users = users,
        _uid = uid,
        super(const UserAdminState());

  final List<User> _users;
  final String _uid;

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

  // void searchChanged(final int value) {
  //   if (value == 1) {
  //     emit(state.copyWith(filteredUsersList: []));
  //   }
  //   if (value == 2) {
  //     final List<User?> filtered = state.usersList.map((final user) {
  //       if (user. == kapplication) {
  //         return user;
  //       }
  //       return null;
  //     }).toList();

  //     emit(state.copyWith(filteredUsersList: filtered));
  //   }

  //   if (value == 3) {
  //     final List<User?> filtered = state.usersList.map((final user) {
  //       if (user.category == krenewal) {
  //         return user;
  //       }
  //       return null;
  //     }).toList();

  //     emit(state.copyWith(filteredUsersList: filtered));
  //   }

  //   if (value == 4) {
  //     final List<User?> filtered = state.usersList.map((final user) {
  //       if (user.category == kcompound) {
  //         return user;
  //       }
  //       return null;
  //     }).toList();

  //     emit(state.copyWith(filteredUsersList: filtered));
  //   }
  // }

  // void datePicked(final DateTime picked) {
  //   final List<User?> filtered = state.usersList.map((final user) {
  //     if (user.timestamp.year == picked.year &&
  //         user.timestamp.month == picked.month &&
  //         user.timestamp.day == picked.day) {
  //       return user;
  //     }
  //     return null;
  //   }).toList();

  //   emit(state.copyWith(filteredUsersList: filtered));
  // }
}
