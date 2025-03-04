import 'package:jobsit_mobile/services/candidate_services.dart';
import 'package:jobsit_mobile/utils/convert_constants.dart';

import '../services/job_services.dart';


class JobPosition{
  final int id;
  final String name;

  JobPosition({required this.id, required this.name});

  factory JobPosition.fromMap(Map<String, dynamic> map) {
    return JobPosition(
        id: int.parse(map[JobServices.idKey].toString()),
        name: map[JobServices.nameKey].toString());
  }

}

class Job {
  final int companyId;
  final String companyName;
  final String? companyLogo;
  final String companyDescription;
  final String jobName;
  final List<JobPosition> positions;
  final int amount;
  final String startDate;
  final String endDate;
  final String location;

  const Job({required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.companyDescription,
    required this.jobName,
    required this.positions,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.location,
  });

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      companyId: int.parse(map[JobServices.companyDTOKey][JobServices.idKey].toString()),
      companyName: map[JobServices.companyDTOKey][JobServices.nameKey] ?? '',
      companyLogo: map[JobServices.companyDTOKey][JobServices.logoKey] ?? '',
      companyDescription: map[JobServices.companyDTOKey][JobServices.descriptionKey] ?? '',
      jobName: map[JobServices.nameKey],
      positions: ConvertConstants.convertToListPositions(map[JobServices.positionDTOsKey] as List<dynamic>),
      amount: int.parse(map[JobServices.amountKey].toString()),
      startDate: map[JobServices.startDateKey].toString(),
      endDate: map[JobServices.endDateKey].toString(),
      location: map[JobServices.locationKey] ?? ''
    );
  }

  // Model
  // static const companyIdField = 'companyId';
  // static const companyNameField = 'companyName';
  // static const companyLogoField = 'companyLogo';
  // static const companyDescriptionField = 'companyDescription';
  // static const companyAddressField = 'companyAddress';
  // static const jobNameField = 'jobName';
  // static const positionsField = 'positions';
  // static const amountField = 'amount';
  // static const startDateField = 'startDate';
  // static const endDateField = 'endDate';
}
