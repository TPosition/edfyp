import 'package:eispkp/add_compound/cubit/add_compound_cubit.dart';
import 'package:eispkp/user_detail/view/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eispkp/compounds/bloc/compounds_bloc.dart';
import 'package:eispkp/common/views/success_page.dart';
import 'package:compounds_repository/compounds_repository.dart';
import 'package:formz/formz.dart';
import 'package:users_repository/users_repository.dart';

class AddCompoundForm extends StatelessWidget {
  const AddCompoundForm({final Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) {
    final compoundsList = context.select(
      (final AddCompoundCubit bloc) => bloc.state.compoundsList,
    );
    final selectedCompound = context.select(
      (final AddCompoundCubit bloc) => bloc.state.lid,
    );

    final sizeWidth = MediaQuery.of(context).size.width * 3 / 4;

    return BlocListener<AddCompoundCubit, AddCompoundState>(
      listener: (final context, final state) {
        if (state.status.isSubmissionSuccess) {
          try {
            context.read<CompoundsBloc>().add(AddCompound(
                  Compound(
                    uid: user.uid,
                    agency: '',
                    amount: state.amount.toDouble(),
                    isPaid: false,
                    plate: state.plate,
                    reason: state.reason,
                  ),
                ));
          } on Exception {}

          Navigator.of(context).push<void>(SuccessPage.route());
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submit Failure')),
            );
        }
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              const Text(
                                'Add Compound',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      user.uid.substring(0, 5),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                        fontSize: 12,
                                      )),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDetailPage(
                                                uid: user.uid,
                                              ),
                                            ));
                                      },
                                      child: const Text('detail'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Plate',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: sizeWidth,
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: const _PlateInput()),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Reason',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: sizeWidth,
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: const _ReasonInput()),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: sizeWidth,
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: const _AmountInput()),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              await context
                                  .read<AddCompoundCubit>()
                                  .addcompoundFormSubmitted(user.uid);
                            },
                            color: Colors.yellowAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              "Add compound",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _periodWidget(final double sizeWidth, final BuildContext context,
          final List<int> periodList) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 25,
            ),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      'Period (month)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              top: 2,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: sizeWidth,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: context.select(
                      (final AddCompoundCubit bloc) => bloc.state.period,
                    ),
                    items: periodList
                        .map<DropdownMenuItem<int>>(
                          (final int item) => DropdownMenuItem<int>(
                            value: item,
                            child: Text(item.toString()),
                          ),
                        )
                        .toList(),
                    onChanged: (final int? value) {
                      // context.read<AddCompoundCubit>().periodChanged(value!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _ReasonInput extends StatelessWidget {
  const _ReasonInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<AddCompoundCubit, AddCompoundState>(
        buildWhen: (final previous, final current) =>
            previous.reason != current.reason,
        builder: (final context, final state) => Flexible(
          child: TextFormField(
            key: const Key('addCompoundForm_ReasonInput_textField'),
            onChanged: (final reason) =>
                context.read<AddCompoundCubit>().reasonChanged(reason),
            decoration: const InputDecoration(
              hintText: "Enter Your Reason",
            ),
          ),
        ),
      );
}

class _PlateInput extends StatelessWidget {
  const _PlateInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<AddCompoundCubit, AddCompoundState>(
        buildWhen: (final previous, final current) =>
            previous.plate != current.plate,
        builder: (final context, final state) => Flexible(
          child: TextFormField(
            key: const Key('addCompoundForm_PlateInput_textField'),
            onChanged: (final plate) =>
                context.read<AddCompoundCubit>().plateChanged(plate),
            decoration: const InputDecoration(
              hintText: "Enter The Plate Number",
            ),
          ),
        ),
      );
}

class _AmountInput extends StatelessWidget {
  const _AmountInput({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<AddCompoundCubit, AddCompoundState>(
        buildWhen: (final previous, final current) =>
            previous.amount != current.amount,
        builder: (final context, final state) => Flexible(
          child: TextFormField(
            key: const Key('addCompoundForm_AmountInput_textField'),
            onChanged: (final amount) {
              if (amount != '')
                context
                    .read<AddCompoundCubit>()
                    .amountChanged(double.parse(amount));
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter Your Phone Number",
            ),
          ),
        ),
      );
}
