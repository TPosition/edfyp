part of 'info_update_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class InfoUpdateState extends Equatable {
  const InfoUpdateState({
    final this.displayName = const StringInput.pure(),
    final this.mobile = const StringInput.pure(),
    final this.status = FormzStatus.pure,
    final this.hasImage = false,
    final this.address = const StringInput.pure(),
    final this.gender = const StringInput.pure(),
    final this.fname = const StringInput.pure(),
    final this.lname = const StringInput.pure(),
    final this.nationality = const StringInput.pure(),
    final this.passport = const StringInput.pure(),
    final this.country = const StringInput.pure(),
    final this.postCode = const StringInput.pure(),
    final this.city = const StringInput.pure(),
    final this.state = const StringInput.pure(),
    final this.marital = const StringInput.pure(),
  });

  final StringInput displayName;
  final StringInput mobile;
  final FormzStatus status;
  final bool hasImage;
  final StringInput address;
  final StringInput gender;
  final StringInput fname;
  final StringInput lname;
  final StringInput nationality;
  final StringInput passport;
  final StringInput country;
  final StringInput postCode;
  final StringInput city;
  final StringInput state;
  final StringInput marital;

  @override
  List<Object> get props => [
        displayName,
        mobile,
        status,
        hasImage,
        address,
        gender,
        fname,
        lname,
        nationality,
        passport,
        country,
        postCode,
        city,
        state,
        marital,
      ];

  InfoUpdateState copyWith({
    final StringInput? displayName,
    final StringInput? mobile,
    final FormzStatus? status,
    final bool? hasImage,
    final StringInput? address,
    final StringInput? gender,
    final StringInput? fname,
    final StringInput? lname,
    final StringInput? nationality,
    final StringInput? passport,
    final StringInput? country,
    final StringInput? postCode,
    final StringInput? city,
    final StringInput? state,
    final StringInput? marital,
  }) =>
      InfoUpdateState(
        displayName: displayName ?? this.displayName,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        hasImage: hasImage ?? this.hasImage,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        nationality: nationality ?? this.nationality,
        passport: passport ?? this.passport,
        country: country ?? this.country,
        postCode: postCode ?? this.postCode,
        city: city ?? this.city,
        state: state ?? this.state,
        marital: marital ?? this.marital,
      );
}
