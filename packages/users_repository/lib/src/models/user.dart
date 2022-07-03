import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class User extends Equatable {
  const User({
    required final this.uid,
    required final this.balance,
    required final this.displayName,
    required final this.email,
    required final this.mobile,
    required final this.photoURL,
    required final this.address,
    required final this.gender,
    required final this.fname,
    required final this.lname,
    required final this.nationality,
    required final this.passport,
    required final this.country,
    required final this.postCode,
    required final this.city,
    required final this.state,
    required final this.marital,
  });

  final String uid;
  final double balance;
  final String displayName;
  final String email;
  final String mobile;
  final String photoURL;
  final String address;
  final String gender;
  final String fname;
  final String lname;
  final String nationality;
  final String passport;
  final String country;
  final String postCode;
  final String city;
  final String state;
  final String marital;

  User copyWith({
    final double? balance,
    final String? displayName,
    final String? email,
    final String? mobile,
    final String? photoURL,
    final String? address,
    final String? gender,
    final String? fname,
    final String? lname,
    final String? nationality,
    final String? passport,
    final String? country,
    final String? postCode,
    final String? city,
    final String? state,
    final String? marital,
  }) =>
      User(
        uid: uid,
        balance: balance ?? this.balance,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        photoURL: photoURL ?? this.photoURL,
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

  @override
  String toString() =>
      'User{uid: $uid,balance: $balance,displayName: $displayName,email: $email,mobile: $mobile,photoURL: $photoURL,address: $address, gender: $gender,fname: $fname, lname: $lname, nationality: $nationality, passport: $passport, country: $country, postCode: $postCode, city: $city, state: $state, marital: $marital}';

  UserEntity toEntity() => UserEntity(
        uid: uid,
        balance: balance,
        displayName: displayName,
        email: email,
        mobile: mobile,
        photoURL: photoURL,
        address: address,
        gender: gender,
        fname: fname,
        lname: lname,
        nationality: nationality,
        passport: passport,
        country: country,
        postCode: postCode,
        city: city,
        state: state,
        marital: marital,
      );

  static User fromEntity(final UserEntity entity) => User(
        uid: entity.uid,
        balance: entity.balance,
        displayName: entity.displayName,
        email: entity.email,
        mobile: entity.mobile,
        photoURL: entity.photoURL,
        address: entity.address,
        gender: entity.gender,
        fname: entity.fname,
        lname: entity.lname,
        nationality: entity.nationality,
        passport: entity.passport,
        country: entity.country,
        postCode: entity.postCode,
        city: entity.city,
        state: entity.state,
        marital: entity.marital,
      );

  static User empty() => const User(
        uid: "",
        balance: 0,
        displayName: "",
        email: "",
        mobile: "",
        photoURL: "",
        address: "",
        gender: '',
        fname: '',
        lname: '',
        nationality: '',
        passport: '',
        country: '',
        postCode: '',
        city: '',
        state: '',
        marital: '',
      );

  @override
  List<Object?> get props => [
        uid,
        balance,
        displayName,
        email,
        mobile,
        photoURL,
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
}
