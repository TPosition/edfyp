import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eispkp/licenses/bloc/licenses_bloc.dart';
import 'package:eispkp/renewal/cubit/renewal_cubit.dart';
import 'package:eispkp/common/views/success_page.dart';
import 'package:eispkp/current_user/bloc/current_user_bloc.dart';
import 'package:eispkp/transactions/bloc/transactions_bloc.dart';
import 'package:eispkp/transactions/transaction_category_constant.dart';
import 'package:licenses_repository/licenses_repository.dart';
import 'package:transactions_repository/transactions_repository.dart';
import '/app/app.dart';
import '/common/widgets/avatar.dart';
import '/info_update/cubit/info_update_cubit.dart';
import 'package:formz/formz.dart';
import 'package:storage_repository/storage_repository.dart';

class RenewalForm extends StatelessWidget {
  const RenewalForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    final licensesList = context.select(
      (final RenewalCubit bloc) => bloc.state.licensesList,
    );
    final selectedLicense = context.select(
      (final RenewalCubit bloc) => bloc.state.lid,
    );

    final periodList = [1, 2, 3, 4, 5];
    final ldlPeriodList = [3, 6, 12, 24];
    final vlPeriodList = [12];
    final cdlPeriodList = [12, 24, 36, 48, 60];

    final sizeWidth = MediaQuery.of(context).size.width * 3 / 4;

    return BlocListener<RenewalCubit, RenewalState>(
      listener: (final context, final state) {
        if (state.status.isSubmissionSuccess) {
          try {
            context.read<LicensesBloc>().add(UpdateLicense(
                  License(
                    uid: user.uid,
                    type: selectedLicense.type,
                    lclass: selectedLicense.lclass,
                    period: selectedLicense.period,
                    department: selectedLicense.department,
                    expiry:
                        DateTime.now().add(Duration(days: state.period * 30)),
                    status: "pending",
                    id: selectedLicense.id,
                  ),
                ));

            context.read<TransactionsBloc>().add(
                  AddTransaction(
                    Transaction(
                      amount: state.amount.toDouble(),
                      category: krenewal,
                      receiverDisplayName: user.displayName,
                      receiverUID: user.uid,
                    ),
                  ),
                );
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
                                'Renewal',
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
                                  children: const <Widget>[
                                    Text(
                                      'Type of license',
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
                                  child: TypeDropdownButton(
                                      licensesList: licensesList),
                                ),
                              ],
                            ),
                          ),
                          if (selectedLicense.type == 'LDL')
                            _periodWidget(sizeWidth, context, ldlPeriodList),
                          if (selectedLicense.type == 'VL')
                            _periodWidget(sizeWidth, context, vlPeriodList),
                          if (selectedLicense.type == 'CDL')
                            _periodWidget(sizeWidth, context, cdlPeriodList),
                          const SizedBox(
                            height: 20,
                          ),
                          if (selectedLicense.type == 'LDL' ||
                              selectedLicense.type == 'VL' ||
                              selectedLicense.type == 'CDL')
                            MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                await context
                                    .read<RenewalCubit>()
                                    .renewalFormSubmitted(
                                        user.uid,
                                        user.email,
                                        user.displayName,
                                        user.mobile,
                                        selectedLicense);
                              },
                              color: Colors.yellowAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Pay ${context.select((final RenewalCubit bloc) => bloc.state.amount)}",
                                style: const TextStyle(
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
                      (final RenewalCubit bloc) => bloc.state.period,
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
                      context.read<RenewalCubit>().periodChanged(value!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class TypeDropdownButton extends StatefulWidget {
  const TypeDropdownButton({
    final Key? key,
    required this.licensesList,
  }) : super(key: key);

  final List<License> licensesList;

  @override
  State<TypeDropdownButton> createState() => _TypeDropdownButtonState();
}

class _TypeDropdownButtonState extends State<TypeDropdownButton> {
  int index = 0;

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    return DropdownButton(
      underline: const SizedBox(),
      isExpanded: true,
      value: context.select(
        (final RenewalCubit bloc) => bloc.state.licensesList[index],
      ),
      items: widget.licensesList
          .where((final element) => element.uid == user.uid)
          .map<DropdownMenuItem<License>>(
            (final item) => DropdownMenuItem<License>(
              value: item,
              child: Text(
                  '${item.type}: ${item.timestamp.day}/${item.timestamp.month}/${item.timestamp.year} - ${item.expiry.day}/${item.expiry.month}/${item.expiry.year}'),
            ),
          )
          .toList(),
      onChanged: (final License? value) {
        context.read<RenewalCubit>().lidChanged(value!);
        setState(() {
          if (value != null) index = widget.licensesList.indexOf(value);
        });
      },
    );
  }
}
