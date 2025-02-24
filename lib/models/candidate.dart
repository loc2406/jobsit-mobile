import 'package:jobsit_mobile/services/candidate_services.dart';

class Candidate {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final bool isMale;
  final String? birthdate;
  final String phone;
  final String? avatar;
  final String? location;
  final bool mailReceive;
  final bool searchable;
  final String? university;
  final String? cv;

  const Candidate({required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.isMale = true,
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
      isMale: map[CandidateServices.userDTOKey][genderField],
      birthdate: map[CandidateServices.userDTOKey][birthdateField],
      phone: map[CandidateServices.userDTOKey][phoneField],
      avatar: map[CandidateServices.userDTOKey][avatarField],
      location: map[CandidateServices.userDTOKey][locationField],
      mailReceive: map[CandidateServices.userDTOKey][mailReceiveField],
      searchable: map[CandidateServices.candidateOtherInfoDTOKey][searchableField],
      university: map[CandidateServices.candidateOtherInfoDTOKey][universityDTOField]['name'],
      cv: map[CandidateServices.candidateOtherInfoDTOKey][cvField],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      emailField: email,
      firstNameField: firstName,
      lastNameField: lastName,
      genderField: isMale,
      birthdateField: birthdate,
      phoneField: phone,
      avatarField: avatar,
      locationField: location,
      mailReceiveField: mailReceive,
    };
  }

  // Model
  static const idField = 'id';
  static const emailField = 'email';
  static const firstNameField = 'firstName';
  static const lastNameField = 'lastName';
  static const genderField = 'gender';
  static const birthdateField = 'birthdate';
  static const phoneField = 'phone';
  static const avatarField = 'avatar';
  static const locationField = 'location';
  static const mailReceiveField = 'mailReceive';
  static const searchableField = 'searchable';
  static const universityDTOField = 'universityDTO';
  static const cvField = 'cv';
}
