part of 'complaint_cubit.dart';

class ComplaintState extends Equatable {
  const ComplaintState({
    final this.complaintsList = const [],
    final this.filteredComplaintsList = const [],
  });

  final List<Complaint> complaintsList;
  final List<Complaint?> filteredComplaintsList;

  @override
  List<Object> get props => [complaintsList, filteredComplaintsList];

  ComplaintState copyWith({
    final List<Complaint>? complaintsList,
    final List<Complaint?>? filteredComplaintsList,
  }) =>
      ComplaintState(
        complaintsList: complaintsList ?? this.complaintsList,
        filteredComplaintsList:
            filteredComplaintsList ?? this.filteredComplaintsList,
      );
}
