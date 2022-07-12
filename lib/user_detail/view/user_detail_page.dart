import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common/widgets/avatar.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/users/bloc/users_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_repository/users_repository.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({final Key? key, required final this.uid})
      : super(key: key);

  final String uid;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.white,
          child: ListView(
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
                  ],
                ),
              ),
              BlocBuilder<UsersBloc, UsersState>(
                builder: (final context, final state) {
                  if (state is UsersLoaded) {
                    final user = state.users[state.users
                        .indexWhere((element) => element.uid == uid)];
                    return Column(
                      children: <Widget>[
                        if (user.registrationNumber.isNotEmpty)
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                const _AppBarCompany(),
                                Container(
                                  color: const Color(0xffFFFFFF),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const _InfoRegistrationNumber(),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        _InfoUserRegistrationNumber(user: user),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const _InfoRegistrationType(),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        _InfoUserRegistrationType(user: user),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const _InfoCompanyType(),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        _InfoUserCompanyType(user: user),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              const _AppBar(),
                              _ProfileAvatar(user: user)
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
                                const SizedBox(
                                  height: 10,
                                ),
                                const _InfoName(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserName(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoEmail(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserEmail(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoMobile(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserMobile(user: user),
                                const _InfoAddress(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserAddress(user: user),
                                const _InfoPassport(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserPassport(user: user),
                                const _InfoNationality(),
                                const SizedBox(
                                  height: 15,
                                ),
                                _InfoUserNationality(user: user),
                                const SizedBox(
                                  height: 20,
                                ),
                                const _InfoMarital(),
                                _InfoUserMarital(user: user),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ));
  }
}

class _InfoUserMobile extends StatelessWidget {
  const _InfoUserMobile({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 2,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.mobile,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoMobile extends StatelessWidget {
  const _InfoMobile({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Mobile',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _InfoUserEmail extends StatelessWidget {
  const _InfoUserEmail({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.email,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoEmail extends StatelessWidget {
  const _InfoEmail({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Email',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
}

class _InfoUserName extends StatelessWidget {
  const _InfoUserName({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              "${user.fname} ${user.lname}",
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoName extends StatelessWidget {
  const _InfoName({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Name',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _InfoUserAddress extends StatelessWidget {
  const _InfoUserAddress({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              '''
${user.address}
${user.postCode} ${user.city}
 ${user.province}
              ''',
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoAddress extends StatelessWidget {
  const _InfoAddress({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Address',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Image.network(
                user.photoURL,
                fit: BoxFit.fitWidth,
                loadingBuilder: (final BuildContext context, final Widget child,
                    final ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}

class _InfoUserPassport extends StatelessWidget {
  const _InfoUserPassport({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 2,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.passport,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoPassport extends StatelessWidget {
  const _InfoPassport({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Passport',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _InfoUserNationality extends StatelessWidget {
  const _InfoUserNationality({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 2,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.nationality,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoNationality extends StatelessWidget {
  const _InfoNationality({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Nationality',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _InfoUserMarital extends StatelessWidget {
  const _InfoUserMarital({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 2,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.marital,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoMarital extends StatelessWidget {
  const _InfoMarital({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Marital',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ));
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Personal Information',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
          )
        ],
      ));
}

class _AppBarCompany extends StatelessWidget {
  const _AppBarCompany({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Company Information',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
          )
        ],
      ));
}

class _InfoUserRegistrationNumber extends StatelessWidget {
  const _InfoUserRegistrationNumber({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.registrationNumber,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoRegistrationNumber extends StatelessWidget {
  const _InfoRegistrationNumber({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'RegistrationNumber',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
}

class _InfoUserRegistrationType extends StatelessWidget {
  const _InfoUserRegistrationType({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.registrationType,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoRegistrationType extends StatelessWidget {
  const _InfoRegistrationType({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'RegistrationType',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
}

class _InfoUserCompanyType extends StatelessWidget {
  const _InfoUserCompanyType({
    required final this.user,
    final Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              user.companyType,
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ));
}

class _InfoCompanyType extends StatelessWidget {
  const _InfoCompanyType({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'CompanyType',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
}
