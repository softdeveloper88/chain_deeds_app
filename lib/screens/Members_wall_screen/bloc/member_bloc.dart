import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/model/member_wall_model/member_message_model.dart';
import 'package:chain_deeds_app/repository/member_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/profile_service.dart';
import 'member_event.dart';
import 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberService _serviceApi = MemberService();
  final ProfileService _authServiceCountry = ProfileService();

  MemberMessageModel? memberMessageModel;
  final int nextPageTrigger = 1;
  bool isLoading = false;
  CountryModel? countryModel;
  MemberBloc() : super(MemberInitial()) {
    on<MemberDataEvent>(_getMemberData);
    on<GetCountryEvent>(_getCounties);
    on<AddCampaignIdea>(_addCampaignIdea);
    on<SendMessageMemberEvent>(_sendMessageMember);
    on<MembersWallMessageReactionEvent>(_setMemberWallReaction);
    on<CheckIfNeedMoreDataEvent>((event, emit) async {
      // emit(PaginationLoadingState());
      // if (event.offset == memberMessageModel?.data.messages.messages.length - nextPageTrigger) {
      add(MemberDataEvent(event.offset));
      // }
    });
  }

  _getMemberData(MemberDataEvent event, Emitter<MemberState> emit) async {
    // ProgressDialogUtils.showProgressDialog();
    try {
      if (event.offset == 1) {
        emit(MemberInitial());
        emit(MemberLoading());
        memberMessageModel = await _serviceApi.getMemberData(event.offset);
        emit(MemberSuccess({}));
      } else {
        emit(MemberSuccess({}));
        isLoading = true;
        // Load more data (pagination)
        MemberMessageModel newMemberMessageModel =
            await _serviceApi.getMemberData(event.offset);
        print(event.offset);
        // Merge the new blogs into the existing memberMessageModel
        memberMessageModel?.data.blogs
            ?.addAll(newMemberMessageModel.data.blogs ?? []);
        // Merge the new messages into the existing memberMessageModel
        if (newMemberMessageModel.data.messages?.messages.isNotEmpty ?? false) {
          newMemberMessageModel.data.messages?.messages
              .forEach((newDate, newMessages) {
            if (memberMessageModel?.data.messages?.messages
                    .containsKey(newDate) ==
                true) {
              // If the date already exists, append the new messages
              memberMessageModel?.data.messages?.messages[newDate]
                  ?.addAll(newMessages);
            } else {
              // If the date does not exist, add the new date and messages
              memberMessageModel?.data.messages?.messages[newDate] =
                  newMessages;
            }
          });
        }
      }
      isLoading = false;

      emit(MemberSuccess(memberMessageModel));
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberFailure("Data Get failed: ${e.toString()}"));
    }
  }

  _sendMessageMember(
      SendMessageMemberEvent event, Emitter<MemberState> emit) async {
    // ProgressDialogUtils.showProgressDialog();
    // emit(MemberLoading());
    try {
      Map<String, dynamic> response = await _serviceApi.sendMessageMemberWall(
          event.message, event.audio, event.document);
      memberMessageModel = await _serviceApi.getMemberData(1);

      // ProgressDialogUtils.hideProgressDialog();
      print(response.toString());
      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberSuccess(response));
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberFailure("Data Get failed: ${e.toString()}"));
    }
  }
  _addCampaignIdea(
      AddCampaignIdea event, Emitter<MemberState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(MemberLoading());
    try {
      Map<String, dynamic> response = await _serviceApi.addCampaignIdea(
          event.countryId, event.title, event.description);
      ProgressDialogUtils.hideProgressDialog();

      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberSuccess(response));
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      emit(MemberFailure("Data Get failed: ${e.toString()}"));
    }
  }
  _setMemberWallReaction(
      MembersWallMessageReactionEvent event, Emitter<MemberState> emit) async {
    // ProgressDialogUtils.showProgressDialog();
    // emit(MemberLoading());
    try {

      Map<String, dynamic> response = await _serviceApi.membersWallMessageReaction(
          event.messageId, event.action);
      // ProgressDialogUtils.hideProgressDialog();

      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberSuccess(response));
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberFailure("Data Get failed: ${e.toString()}"));
    }
  }
  _getCounties(
      GetCountryEvent event, Emitter<MemberState> emit) async {
    // ProgressDialogUtils.showProgressDialog();
    emit(MemberLoading());
    try {
     countryModel  = await _authServiceCountry.getCountries();
      // ProgressDialogUtils.hideProgressDialog();

      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberSuccess({}));
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(MemberFailure("Data Get failed: ${e.toString()}"));
    }
  }
}
