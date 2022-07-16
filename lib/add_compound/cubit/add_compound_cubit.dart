import 'package:bloc/bloc.dart';
import 'package:compounds_repository/compounds_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'add_compound_state.dart';

class AddCompoundCubit extends Cubit<AddCompoundState> {
  AddCompoundCubit(
      this._compoundsRepository, this._razorpay, List<Compound> compounds)
      : super(AddCompoundState(
            lid: Compound(
          agency: '',
          amount: 0,
          isPaid: false,
          plate: '',
          reason: '',
          uid: '',
        )));

  final FirebaseCompoundsRepository _compoundsRepository;
  final Razorpay _razorpay;

  void init() {}

  void amountChanged(final double value) {
    emit(
      state.copyWith(
        amount: value,
      ),
    );
  }

  void reasonChanged(final String value) {
    emit(
      state.copyWith(
        reason: value,
      ),
    );
  }

  void plateChanged(final String value) {
    emit(
      state.copyWith(
        plate: value,
      ),
    );
  }

  Future<void> addcompoundFormSubmitted(
    final String uid,
  ) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
