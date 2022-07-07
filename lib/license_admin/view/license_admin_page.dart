import 'package:eispkp/license_admin/cubit/license_admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/licenses/bloc/licenses_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licenses_repository/licenses_repository.dart';

class LicenseAdminPage extends StatelessWidget {
  const LicenseAdminPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const LicenseAdminPage(),
      );

  @override
  Widget build(final BuildContext context) {
    const int _dropdownValue = 1;
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    final DateTime selectedDate = DateTime.now();

    Future _selectDate(final BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        context.read<LicenseAdminCubit>().datePicked(picked);
      }
    }

    return BlocBuilder<LicensesBloc, LicensesState>(
      builder: (final context, final state) {
        if (state is LicensesLoaded) {
          return BlocProvider(
            create: (final context) => LicenseAdminCubit(
              licenses: state.licenses,
              uid: user.uid,
            )..init(),
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F4F4),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 50, bottom: 25),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            const Text(
                              'Licenses',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    child: BlocBuilder<LicenseAdminCubit,
                                        LicenseAdminState>(
                                      builder: (final context, final state) =>
                                          DropdownButton(
                                        hint: const Text('Category'),
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        value: _dropdownValue,
                                        items: [
                                          DropdownMenuItem(
                                            value: 1,
                                            child: Text(
                                              "All",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: 2,
                                            child: Text(
                                              "Application",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                              value: 3,
                                              child: Text(
                                                "Renewal",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          DropdownMenuItem(
                                              value: 4,
                                              child: Text(
                                                "Compound",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          DropdownMenuItem(
                                            value: 5,
                                            child: Text(
                                              "Date",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                        onChanged: (final int? value) {
                                          if (value != null) {
                                            context
                                                .read<LicenseAdminCubit>()
                                                .searchChanged(value);
                                          }

                                          if (value == 5) {
                                            _selectDate(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<LicenseAdminCubit, LicenseAdminState>(
                    buildWhen: (final previous, final current) =>
                        previous.filteredLicensesList !=
                        current.filteredLicensesList,
                    builder: (final context, final state) => Expanded(
                      child: ListView.builder(
                          itemCount: state.filteredLicensesList.isEmpty
                              ? state.licensesList.length
                              : state.filteredLicensesList.length,
                          itemBuilder: (final BuildContext context,
                                  final int index) =>
                              _statusWidget(state.filteredLicensesList.isEmpty
                                  ? state.licensesList[index]
                                  : state.filteredLicensesList[index])),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _statusWidget(final License? license) =>
      Builder(builder: (final context) {
        final user =
            context.select((final CurrentUserBloc bloc) => bloc.state.user);
        if (license != null) {
          return SingleChildScrollView(
            child: Container(
              height: 130,
              margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: SizedBox(),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  license.id.substring(0, 6),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      license.type + ' - ',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      license.lclass,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Text(
                                  license.department,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _statusDropdown(license: license),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "${license.timestamp.day}/${license.timestamp.month}/${license.timestamp.year} - ${license.expiry.day}/${license.expiry.month}/${license.expiry.year}",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      });
}

class _statusDropdown extends StatefulWidget {
  const _statusDropdown({
    final Key? key,
    required final this.license,
  }) : super(key: key);

  final License license;

  @override
  State<_statusDropdown> createState() => _statusDropdownState();
}

class _statusDropdownState extends State<_statusDropdown> {
  @override
  Widget build(final BuildContext context) {
    String dropdownvalue = widget.license.status;
    var items = [
      'pending',
      'approved',
      'denied',
    ];
    return BlocBuilder<LicenseAdminCubit, LicenseAdminState>(
        buildWhen: (final previous, current) =>
            previous.statusDropdown != current.statusDropdown,
        builder: (final context, final state) => Container(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                value: widget.license.status,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  context.read<LicensesBloc>().add(
                        UpdateLicense(
                          License(
                            id: widget.license.id,
                            uid: widget.license.uid,
                            type: widget.license.type,
                            lclass: widget.license.lclass,
                            period: widget.license.period,
                            department: widget.license.department,
                            expiry: widget.license.expiry,
                            status: newValue!,
                          ),
                        ),
                      );
                  setState(() {
                    dropdownvalue = newValue;
                  });

                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {
                      // Here you can write your code for open new view

                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .push<void>(LicenseAdminPage.route());
                    });
                  });
                },
              ),
            ));
  }
}
