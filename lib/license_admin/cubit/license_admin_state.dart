part of 'license_admin_cubit.dart';

class LicenseAdminState extends Equatable {
  const LicenseAdminState({
    final this.licensesList = const [],
    final this.filteredLicensesList = const [],
    final this.statusDropdown = 0,
  });

  final List<License> licensesList;
  final List<License?> filteredLicensesList;
  final int statusDropdown;

  @override
  List<Object> get props =>
      [licensesList, filteredLicensesList, statusDropdown];

  LicenseAdminState copyWith({
    final List<License>? licensesList,
    final List<License?>? filteredLicensesList,
    final int? statusDropdown,
  }) =>
      LicenseAdminState(
        licensesList: licensesList ?? this.licensesList,
        filteredLicensesList: filteredLicensesList ?? this.filteredLicensesList,
        statusDropdown: statusDropdown ?? this.statusDropdown,
      );
}
