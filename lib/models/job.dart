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

class JobSchedule{
  final int id;
  final String name;

  JobSchedule({required this.id, required this.name});

  factory JobSchedule.fromMap(Map<String, dynamic> map) {
    return JobSchedule(
        id: int.parse(map[JobServices.idKey].toString()),
        name: map[JobServices.nameKey].toString());
  }
}

class Job {
  final int companyId;
  final String companyName;
  final String? companyLogo;
  final String companyDescription;
  final int jobId;
  final String jobName;
  final String jobDescription;
  final List<JobPosition> positions;
  final List<JobSchedule> schedules;
  final int amount;
  final String startDate;
  final String endDate;
  final String location;
  final int salaryMin;
  final int salaryMax;

  const Job({required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.companyDescription,
    required this.jobId,
    required this.jobName,
    required this.jobDescription,
    required this.positions,
    required this.schedules,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.salaryMin,
    required this.salaryMax,
  });

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      companyId: int.parse(map[JobServices.companyDTOKey][JobServices.idKey].toString()),
      companyName: map[JobServices.companyDTOKey][JobServices.nameKey] ?? '',
      companyLogo: map[JobServices.companyDTOKey][JobServices.logoKey] ?? '',
      companyDescription: map[JobServices.companyDTOKey][JobServices.descriptionKey] ?? '',
      jobId: int.parse(map[JobServices.idKey].toString()),
      jobName: map[JobServices.nameKey],
      jobDescription: map[JobServices.descriptionKey],
      positions: ConvertConstants.convertToListJobPositions(map[JobServices.positionDTOsKey] as List<dynamic>),
      schedules: ConvertConstants.convertToListJobSchedules(map[JobServices.scheduleDTOsKey] as List<dynamic>),
      amount: int.parse(map[JobServices.amountKey].toString()),
      startDate: map[JobServices.startDateKey].toString(),
      endDate: map[JobServices.endDateKey].toString(),
      location: map[JobServices.locationKey] ?? '',
      salaryMin: int.parse(map[JobServices.salaryMinKey].toString()),
      salaryMax: int.parse(map[JobServices.salaryMaxKey].toString()),
    );
  }

  factory Job.fromSavedMap(Map<String, dynamic> map) {
    return Job(
      companyId: int.parse(map[JobServices.jobDTOKey][JobServices.companyDTOKey][JobServices.idKey].toString()),
      companyName: map[JobServices.jobDTOKey][JobServices.companyDTOKey][JobServices.nameKey] ?? '',
      companyLogo: map[JobServices.jobDTOKey][JobServices.companyDTOKey][JobServices.logoKey] ?? '',
      companyDescription: map[JobServices.jobDTOKey][JobServices.companyDTOKey][JobServices.descriptionKey] ?? '',
      jobId: int.parse(map[JobServices.jobDTOKey][JobServices.idKey].toString()),
      jobName: map[JobServices.jobDTOKey][JobServices.nameKey],
      jobDescription: map[JobServices.jobDTOKey][JobServices.descriptionKey],
      positions: ConvertConstants.convertToListJobPositions(map[JobServices.jobDTOKey][JobServices.positionDTOsKey] as List<dynamic>),
      schedules: ConvertConstants.convertToListJobSchedules(map[JobServices.jobDTOKey][JobServices.scheduleDTOsKey] as List<dynamic>),
      amount: int.parse(map[JobServices.jobDTOKey][JobServices.amountKey].toString()),
      startDate: map[JobServices.jobDTOKey][JobServices.startDateKey].toString(),
      endDate: map[JobServices.jobDTOKey][JobServices.endDateKey].toString(),
      location: map[JobServices.jobDTOKey][JobServices.locationKey] ?? '',
      salaryMin: int.parse(map[JobServices.jobDTOKey][JobServices.salaryMinKey].toString()),
      salaryMax: int.parse(map[JobServices.jobDTOKey][JobServices.salaryMaxKey].toString()),
    );
  }
}
