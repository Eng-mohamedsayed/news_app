// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/states.dart';

import 'package:notizia/shared/network/remote/dio_helper.dart';

class NotiziaCubit extends Cubit<NotiziaStates> {
  NotiziaCubit() : super(NotiziaInitalizeStates());

  static NotiziaCubit get(context) => BlocProvider.of(context);

  //*************** Variables **************************//

  int currentIndex = 0;
  List<dynamic> articls = [];


  bool isLight = true;





  //*************** Methods **************************//

  void changeBottomNav(index) {
    currentIndex = index;
    emit(NotiziaChangeBottomNavigationState());
  }

  void changeTheme() {
    isLight = !isLight;
    emit(NotiziaChangeThemeState());
  }



  void getArticlsData({required String category}) {
    emit(NotiziaGetArticlsLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'eg',
      'apiKey': '443836f0e19e4cffb9dbef9291d0a438',
      'category': category
    }).then((value) {
     
      articls = value.data['articles'];
      emit(NotiziaGetArticlsSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NotiziaGetArticlsErrorState());
    });
  }


  List search = [];

  void getSearchData({required String searchText}) {
    emit(NotiziaGetSearchLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'q': searchText,
      'apiKey': '443836f0e19e4cffb9dbef9291d0a438',
    }).then((value) {
      if(searchText!=''){
        search = value.data['articles'];
        emit(NotiziaGetSearchSucessState());


      }else
      {   
        search=[];
              emit(NotiziaGetSearchSucessState());


      }
    }).catchError((error) {
      print(error.toString());
      emit(NotiziaGetSearchErrorState());
    });
  }
}




