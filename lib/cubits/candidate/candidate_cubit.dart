import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:http/http.dart' as http;
import 'package:jobsit_mobile/cubits/candidate/edit_success_state.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';

import '../../models/candidate.dart';
import '../../models/province.dart';
import '../../models/university.dart';
import '../../services/base_services.dart';
import '../../services/candidate_services.dart';
import '../../services/province_services.dart';

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
      sendActiveEmail(email);
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
  sendOtpToChangePassWord(String otp, String password) async {
    try{
      emit(CandidateState.loading());
      await CandidateServices.sendOtpToChangePassWord(otp,password);
      emit(CandidateState.activeSuccess());
    }catch(e){
      emit(CandidateState.error(e.toString()));
    }
  }
  sendEmailForgotPassWord(String email) async {
    try{
      await CandidateServices.sendEmailForgotPassWord(email);
      emit(CandidateState.sendOtpSuccess());
    }catch(e){
      emit(CandidateState.error(e.toString()));
    }
  }
  Future<List<Province>> getProvinces() async {
    try{
      final provinces = await ProvinceServices.getProvinces();
      return provinces;
    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }
  handleUpdate(
      {required Candidate user,
        required String token,
        required List<int> position,
        required List<int> major,
        required List<int> jobType,
        required String wantJob,
        required String location,
        required String coverLetter,
        required File cv,
      required String avatar,
      required String email ,
      required String password}) async {
    try {
      emit(CandidateState.loading());
      final responseBody = await CandidateServices.updateCandidateJob(
          user: user, token: token, position: position,major: major,jobType: jobType,
          wantJob: wantJob,location: location,coverLetter: coverLetter,cv: cv, avatar : avatar);
      final responseBodyUser =
      await CandidateServices.loginAccount(email, password);

      final tokenUser = responseBodyUser[CandidateServices.tokenKey].toString();
      final candidateId =
      int.tryParse(responseBodyUser[CandidateServices.idUserKey].toString());

      if (tokenUser.isNotEmpty && candidateId != null) {
        final candidate = await CandidateServices.getCandidateById(candidateId);
        emit(CandidateState.loginSuccess(tokenUser, candidate));
      } else {
        emit(CandidateState.error(TextConstants.tokenOrCandidateIdError));
      }





    } catch (e) {
      emit(CandidateState.error(e.toString()));
    }
  }

  Future<List<String>> getDistricts(int provinceCode) async {
    try{
      final districts = await ProvinceServices.getDistricts(provinceCode);
      return districts;
    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<University>> getUniversities() async {
    try{
      final universities = await CandidateServices.getUniversities();
      return universities;
    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }

  updateInfo({
    required int candidateId,
    required String token,
    required File? avatar,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String phone,
    required bool? gender,
    required String location,
    University? university,
  }) async {
    try {
      emit(CandidateState.loading());

      await CandidateServices.updateCandidate(
          candidateId: candidateId,
          token: token,
          avatar: avatar,
          firstName: firstName,
          lastName: lastName,
          birthdate: birthdate,
          phone: phone,
          gender: gender,
          location: location,
          university: university
      );

      emit(CandidateState.editSuccess());

      final candidate = await CandidateServices.getCandidateById(candidateId);
      emit(CandidateState.loginSuccess(token, candidate));

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateSearchable(int id, String token) async {
    try{
      await CandidateServices.updateSearchable(id, token);
      final candidate = await CandidateServices.getCandidateById(id);
      emit(CandidateState.loginSuccess(token, candidate));
    }catch(e){
      debugPrint(e.toString());
    }
  }

  updateMailReceive(int id, String token) async {
    try{
      await CandidateServices.updateMailReceive(id, token);
      final candidate = await CandidateServices.getCandidateById(id);
      emit(CandidateState.loginSuccess(token, candidate));
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<bool> logout(String token) async {
    try{
      emit(CandidateState.loading());
      await CandidateServices.logout(token);
      emit(CandidateState.noLoggedIn());
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
}
