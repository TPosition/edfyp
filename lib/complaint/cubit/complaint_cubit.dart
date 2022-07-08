import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:complaints_repository/complaint_repository.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit(
      {required final List<Complaint> complaints, required final String uid})
      : _complaints = complaints,
        _uid = uid,
        super(const ComplaintState());

  final List<Complaint> _complaints;
  final String _uid;

  void init() {
    emit(state.copyWith(complaintsList: _complaints));
  }
}
