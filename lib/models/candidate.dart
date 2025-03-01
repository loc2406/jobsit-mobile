import 'package:jobsit_mobile/services/candidate_services.dart';

class Candidate {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final bool? gender;
  final String? birthdate;
  final String phone;
  final String? avatar;
  final String? location;
  final bool mailReceive;
  final bool searchable;
  final Map<String, dynamic>? university;
  final String? cv;

  const Candidate({required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.birthdate,
    required this.phone,
    this.avatar,
    this.location,
    required this.mailReceive,
    required this.searchable,
    this.university,
    this.cv,
  });

  factory Candidate.fromMap(Map<String, dynamic> map) {
    return Candidate(
      id: int.parse(map[idField].toString()),
      email: map[CandidateServices.userDTOKey][emailField] ?? '',
      firstName: map[CandidateServices.userDTOKey][firstNameField],
      lastName: map[CandidateServices.userDTOKey][lastNameField],
      gender: map[CandidateServices.userDTOKey][genderField],
      birthdate: map[CandidateServices.userDTOKey][birthDayField],
      phone: map[CandidateServices.userDTOKey][phoneField],
      avatar: map[CandidateServices.userDTOKey][avatarField],
      location: map[CandidateServices.userDTOKey][locationField],
      mailReceive: map[CandidateServices.userDTOKey][mailReceiveField],
      searchable: map[CandidateServices.candidateOtherInfoDTOKey][searchableField],
      university: map[CandidateServices.candidateOtherInfoDTOKey][universityDTOField],
      cv: map[CandidateServices.candidateOtherInfoDTOKey][cvField] ?? '',
    );
  }

  // Model
  static const idField = 'id';
  static const emailField = 'email';
  static const firstNameField = 'firstName';
  static const lastNameField = 'lastName';
  static const genderField = 'gender';
  static const birthDayField = 'birthDay';
  static const phoneField = 'phone';
  static const avatarField = 'avatar';
  static const locationField = 'location';
  static const mailReceiveField = 'mailReceive';
  static const searchableField = 'searchable';
  static const universityDTOField = 'universityDTO';
  static const cvField = 'cv';
}
