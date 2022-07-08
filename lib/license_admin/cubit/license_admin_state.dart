part of 'license_admin_cubit.dart';

class LicenseAdminState extends Equatable {
  const LicenseAdminState({
    final this.licensesList = const [],
    final this.filteredLicensesList = const [],
    final this.statusDropdown = 0,
    final this.licenseSearch = '',
  });

  final List<License> licensesList;
  final List<License?> filteredLicensesList;
  final int statusDropdown;
  final String licenseSearch;

  @override
  List<Object> get props =>
      [licensesList, filteredLicensesList, statusDropdown, licenseSearch];

  LicenseAdminState copyWith({
    final List<License>? licensesList,
    final List<License?>? filteredLicensesList,
    final int? statusDropdown,
    final String? licenseSearch,
  }) =>
      LicenseAdminState(
        licensesList: licensesList ?? this.licensesList,
        filteredLicensesList: filteredLicensesList ?? this.filteredLicensesList,
        statusDropdown: statusDropdown ?? this.statusDropdown,
        licenseSearch: licenseSearch ?? this.licenseSearch,
      );
}
