import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/modules/Buisness_Scereen.dart';
import 'package:newsynews/modules/Science_Screen.dart';
import 'package:newsynews/modules/Settings_Screen.dart';
import 'package:newsynews/modules/Sports_Screen.dart';
import 'package:newsynews/shared/AppCubit/cubit.dart';
import 'package:newsynews/shared/network/remote/Dio_Helper.dart';

class NewsCubit extends Cubit<NewsAppStates>{
  NewsCubit() : super(InitState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<dynamic> Get_Business = [];
  List<dynamic> Get_Sports = [];
  List<dynamic> Get_Science = [];
  List<dynamic> Get_Search = [];
  dynamic getlengthBusiness;
  dynamic getlengthSports;
  dynamic getlengthScience;
  var APIKey = '029e3730eb0c4b519ccba6946fb8fc64';
  var Error = '';

  List<BottomNavigationBarItem> BottomNavBar = [
    BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(
        Icons.business,
      )
  ),
    BottomNavigationBarItem(
      label:'Sports',
        icon: Icon(
          Icons.sports,
        )
    ),
    BottomNavigationBarItem(
      label: 'Science',
        icon: Icon(
          Icons.science,
        )),
  ];

  List<Widget> screens = [
    Buisness_Screen(),
    Sports_Screen(),
    Science_Screen(),
  ];

  void changeBottomNavBar(int index){
    currentindex = index;
    emit(ChangeNavBar());
    if(index == 0){
      get_business();
    }
    else if(index == 1){
      get_sports();
    }else{
      get_science();
    }

  }

  dynamic get_business() async {
    emit(GetBusinessLoadingState());
    if(Get_Business.length > 0){
      emit(GetBusinessSuccsessState());
    }else{
    DioHelper.GetData
      (
      'v2/top-headlines',
      {
        'country':'eg',
      'category':'business',
      'apiKey':APIKey,
      },
      ).then((value) {
      Get_Business = value.data['articles'];
      getlengthBusiness = value.data['totalResults'];
      emit(GetBusinessSuccsessState());
    }).catchError((error){
      emit(GetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }}

  dynamic get_sports() async{
    emit(GetSportsLoadingState());
    if (Get_Sports.length==0){
      DioHelper.GetData
        (
        'v2/top-headlines',
        {
          'country':'eg',
          'category':'sports',
          'apiKey':APIKey,
        },
      ).then((value) {
        Get_Sports = value.data['articles'];
        getlengthSports = value.data['totalResults'];
        emit(GetSportsSuccsessState());

      }).catchError((error){
        emit(GetSportsErrorState(error.toString()));
        print(error.toString());
      });
    }else{
      emit(GetSportsSuccsessState());
    }
  }

  void get_science() async {
    emit(GetScienceLoadingState());
    if(Get_Science.length==0){
      DioHelper.GetData
        (
        'v2/top-headlines',
        {
          'country':'eg',
          'category':'science',
          'apiKey':APIKey,
        },
      ).then((value) {
        Get_Science = value.data['articles'];
        getlengthScience = value.data['totalResults'];
        emit(GetScienceSuccsessState());

      }).catchError((error){
        Error = error.toString();
        emit(GetScienceErrorState(Error));
      });
    }else{
      emit(GetScienceSuccsessState());
    }

  }

  dynamic search(dynamic text){
    emit(GetSearchLoadingState());
    DioHelper.GetData
      (
      '/v2/everything',
      {
        'q':'$text',
        'apiKey':APIKey,
      },
    ).then((value) {
      Get_Search = value.data['articles'];
      emit(GetSearchSuccsessState());

    }).catchError((error){
      emit(GetSearchErrorState(error.toString()));
      print(error.toString());
    });

  }
  Color RefreshColor(context){
    WholeAppCubit.get(context).isDark ? Colors.black87 : Colors.blue[200];
    emit(RefreshIndicatorColor());
  }

  }

