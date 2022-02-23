// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/modules/business/business_screen.dart';
import 'package:notizia/modules/science/science_screen.dart';
import 'package:notizia/modules/sports/sports_screen.dart';
import 'package:notizia/shared/network/remote/dio_helper.dart';

class NotiziaCubit extends Cubit<NotiziaStates> {
  NotiziaCubit() : super(NotiziaInitalizeStates());

  static NotiziaCubit get(context) => BlocProvider.of(context);

  //*************** Variables **************************//

  int currentIndex = 0;

  List<Widget> screen = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];


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

  List<dynamic> articls = [];

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

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NotiziaGetBusinessLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'eg',
      'apiKey': '443836f0e19e4cffb9dbef9291d0a438',
      'category': 'business'
    }).then((value) {
      business = value.data['articles'];
      emit(NotiziaGetBusinessSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NotiziaGetBusinessErrorState());
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NotiziaGetSportsLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'eg',
      'apiKey': '443836f0e19e4cffb9dbef9291d0a438',
      'category': 'sports'
    }).then((value) {
      sports = value.data['articles'];
      emit(NotiziaGetSportsSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NotiziaGetSportsErrorState());
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NotiziaGetScienceLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'eg',
      'apiKey': '443836f0e19e4cffb9dbef9291d0a438',
      'category': 'science'
    }).then((value) {
      science = value.data['articles'];
      emit(NotiziaGetScienceSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NotiziaGetScienceErrorState());
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




// 
// https://newsapi.org/ ----->Base Url

// v2/everything --------> End Point
// ?q=bitcoin&apiKey=443836f0e19e4cffb9dbef9291d0a438  ------> Query

