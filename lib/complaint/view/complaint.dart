import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/complaint/cubit/complaint_cubit.dart';
import '/complaints/bloc/complaints_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:complaints_repository/complaint_repository.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({final Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ComplaintPage());

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const ComplaintPage(),
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
      if (picked != null && picked != selectedDate) {}
    }

    return BlocBuilder<ComplaintsBloc, ComplaintsState>(
      builder: (final context, final state) {
        if (state is ComplaintsLoaded) {
          return BlocProvider(
            create: (final context) => ComplaintCubit(
                complaints: state.complaints.toList(), uid: user.uid)
              ..init(),
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F4F4),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const Text(
                          'Complaints',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ComplaintCubit, ComplaintState>(
                    buildWhen: (final previous, final current) =>
                        previous.filteredComplaintsList !=
                        current.filteredComplaintsList,
                    builder: (final context, final state) => Expanded(
                      child: ListView.builder(
                          itemCount: state.filteredComplaintsList.isEmpty
                              ? state.complaintsList.length
                              : state.filteredComplaintsList.length,
                          itemBuilder: (final BuildContext context,
                                  final int index) =>
                              _complaintWidget(
                                  state.filteredComplaintsList.isEmpty
                                      ? state.complaintsList[index]
                                      : state.filteredComplaintsList[index])),
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

  Widget _complaintWidget(final Complaint? complaint) =>
      Builder(builder: (final context) {
        final user =
            context.select((final CurrentUserBloc bloc) => bloc.state.user);
        if (complaint != null) {
          return SingleChildScrollView(
            child: Container(
              height: 90,
              margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            complaint.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(complaint.comment),
                          Text(
                            " ${complaint.timestamp.day}/${complaint.timestamp.month}/${complaint.timestamp.year} ${complaint.timestamp.hour}:${complaint.timestamp.minute}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
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
