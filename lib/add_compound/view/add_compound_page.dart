import 'package:eispkp/add_compound/cubit/add_compound_cubit.dart';
import 'package:eispkp/add_compound/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eispkp/compounds/bloc/compounds_bloc.dart';
import 'package:compounds_repository/compounds_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:users_repository/users_repository.dart';

class AddCompoundPage extends StatelessWidget {
  const AddCompoundPage({final Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<CompoundsBloc, CompoundsState>(
        builder: (final context, final state) {
          if (state is CompoundsLoaded) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: BlocProvider<AddCompoundCubit>(
                  create: (final _) => AddCompoundCubit(
                    context.read<FirebaseCompoundsRepository>(),
                    Razorpay(),
                    state.compounds,
                  )..init(),
                  child: AddCompoundForm(
                    user: user,
                  ),
                ),
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      );
}
