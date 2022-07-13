import 'package:eispkp/user_detail/view/user_detail_page.dart';
import 'package:eispkp/users/bloc/users_bloc.dart';
import 'package:eispkp/users_admin/cubit/users_admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class UsersAdminPage extends StatelessWidget {
  const UsersAdminPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const UsersAdminPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: UsersAdminPage(),
      );
  @override
  Widget build(final BuildContext context) {
    const int _dropdownValue = 1;
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);

    return BlocBuilder<UsersBloc, UsersState>(
      builder: (final context, final state) {
        if (state is UsersLoaded) {
          return BlocProvider(
            create: (final context) =>
                UserAdminCubit(users: state.users.toList(), uid: user.uid)
                  ..init(),
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F4F4),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 50, bottom: 25),
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
                  _UIDSearchInput(),
                  BlocBuilder<UserAdminCubit, UserAdminState>(
                    buildWhen: (final previous, final current) =>
                        previous.filteredUsersList != current.filteredUsersList,
                    builder: (final context, final state) => Expanded(
                      child: ListView.builder(
                          itemCount: state.filteredUsersList.isEmpty
                              ? state.usersList.length
                              : state.filteredUsersList.length,
                          itemBuilder: (final BuildContext context,
                                  final int index) =>
                              _useradminWidget(state.filteredUsersList.isEmpty
                                  ? state.usersList[index]
                                  : state.filteredUsersList[index])),
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

  Widget _useradminWidget(final User? user) =>
      Builder(builder: (final context) {
        if (user != null) {
          return SingleChildScrollView(
            child: Container(
              height: 90,
              margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  user.uid.substring(0, 5),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                  fontSize: 12,
                                )),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDetailPage(
                                          uid: user.uid,
                                        ),
                                      ));
                                },
                                child: const Text('detail'),
                              ),
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

class _UIDSearchInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<UserAdminCubit, UserAdminState>(
        buildWhen: (final previous, final current) =>
            previous.uidSearch != current.uidSearch,
        builder: (final context, final state) => Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextField(
                key: const Key('useradminForm_uidSearchInput_textField'),
                onChanged: (final uidSearch) =>
                    context.read<UserAdminCubit>().uidSearchChanged(uidSearch),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  helperText: 'search by user ID',
                ),
              ),
            ],
          ),
        ),
      );
}
