part of 'add_compound_cubit.dart';

class AddCompoundState extends Equatable {
  const AddCompoundState({
    required final this.lid,
    final this.period = 12,
    final this.status = FormzStatus.pure,
    final this.compoundsList = const [],
    final this.reason = '',
    final this.plate = '',
    final this.agency = '',
    final this.amount = 0,
  });

  final Compound lid;
  final FormzStatus status;
  final double amount;
  final int period;
  final List<Compound> compoundsList;
  final String reason;
  final String plate;
  final String agency;

  @override
  List<Object> get props => [
        lid,
        status,
        amount,
        period,
        compoundsList,
        reason,
        plate,
        agency,
      ];

  AddCompoundState copyWith({
    final Compound? lid,
    final int? period,
    final FormzStatus? status,
    final List<Compound>? compoundsList,
    final String? reason,
    final String? plate,
    final String? agency,
    final double? amount,
  }) =>
      AddCompoundState(
        lid: lid ?? this.lid,
        period: period ?? this.period,
        status: status ?? this.status,
        compoundsList: compoundsList ?? this.compoundsList,
        reason: reason ?? this.reason,
        plate: plate ?? this.plate,
        agency: agency ?? this.agency,
        amount: amount ?? this.amount,
      );
}
