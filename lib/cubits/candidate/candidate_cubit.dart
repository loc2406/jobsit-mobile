import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:http/http.dart' as http;

import '../../models/candidate.dart';
import '../../services/base_services.dart';
import '../../services/candidate_services.dart';

class CandidateCubit extends Cubit<CandidateState> {
  CandidateCubit() : super(CandidateState.init());

  Future<void> createCandidate(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone}) async {
    emit(CandidateState.loading());
    try {
      CandidateServices.createCandidate(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone);
    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }

  sendActiveEmail(String email) async {
    try{
      CandidateServices.sendActiveEmail(email);
    }catch(e){
      emit(CandidateState.error(e.toString()));
    }
  }
}
