import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../../models/candidate.dart';
import '../../services/base_services.dart';
import '../../services/candidate_services.dart';

class CandidateCubit extends Cubit<CandidateState> {
  CandidateCubit() : super(CandidateState.noLoggedIn());

  Future<void> createCandidate(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone}) async {
    emit(CandidateState.loading());
    try {
      await CandidateServices.createCandidate(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phone: phone);
      emit(CandidateState.registerSuccess(email));
    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }

  sendActiveEmail(String email) async {
    try {
      await CandidateServices.sendActiveEmail(email);
      emit(CandidateState.sendOtpSuccess());
    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }

  sendOtpToActiveAccount(String otp) async {
    try {
      emit(CandidateState.loading());
      await CandidateServices.sendOtpToActiveAccount(otp);
      emit(CandidateState.activeSuccess());
    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }

  loginAccount({required String email, required String password}) async {
    try {
      emit(CandidateState.loading());
      final responseBody =
          await CandidateServices.loginAccount(email, password);

      final token = responseBody[CandidateServices.tokenKey].toString();
      final candidateId =
          int.tryParse(responseBody[CandidateServices.idUserKey].toString());

      if (token.isNotEmpty && candidateId != null) {
        final candidate = await CandidateServices.getCandidateById(candidateId);
        emit(CandidateState.loginSuccess(token, candidate));
      } else {
        emit(CandidateState.error(TextConstants.tokenOrCandidateIdError));
      }
    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }

  updateInfo({
    required int candidateId,
    required String token,
    required File? avatar,
    required String firstName,
    required String lastName,
    required String email,
    required String birthdate,
    required String phone,
    required String gender,
  }) async {
    try {
      emit(CandidateState.loading());

      await CandidateServices.update(
          candidateId: candidateId,
          token: token,
          avatar: avatar,
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthdate: birthdate,
          phone: phone,
          gender: gender);

      final candidate = await CandidateServices.getCandidateById(candidateId);
      emit(CandidateState.loginSuccess(token, candidate));

    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }
}
