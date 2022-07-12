part of 'history_cubit.dart';

class HistoryState extends Equatable {
  const HistoryState({
    final this.transactionsList = const [],
    final this.filteredTransactionsList = const [],
    final this.licenseSearch = '',
  });

  final List<Transaction> transactionsList;
  final List<Transaction?> filteredTransactionsList;
  final String licenseSearch;

  @override
  List<Object> get props =>
      [transactionsList, filteredTransactionsList, licenseSearch];

  HistoryState copyWith({
    final List<Transaction>? transactionsList,
    final List<Transaction?>? filteredTransactionsList,
    final String? licenseSearch,
  }) =>
      HistoryState(
        transactionsList: transactionsList ?? this.transactionsList,
        filteredTransactionsList:
            filteredTransactionsList ?? this.filteredTransactionsList,
        licenseSearch: licenseSearch ?? this.licenseSearch,
      );
}
