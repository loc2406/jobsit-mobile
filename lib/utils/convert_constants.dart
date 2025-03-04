import '../models/job.dart';

class ConvertConstants{
  static List<JobPosition> convertToListPositions(List<dynamic> list) {
    return list.map((map) => JobPosition.fromMap(map as Map<String, dynamic>)).toList();
  }
}