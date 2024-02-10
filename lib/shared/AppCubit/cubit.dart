
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/shared/AppCubit/states.dart';
import 'package:newsynews/shared/network/local/cache_helper.dart';

class WholeAppCubit extends Cubit<AppCubitStates> {

  WholeAppCubit() : super(InitApp());

  static WholeAppCubit get(context) => BlocProvider.of(context);

bool isDark = false;

  void Toggle({bool FromShared}){
    if(FromShared != null){
      isDark = FromShared;
      emit(ToggleMode());
    }else{
    isDark = !isDark;
    CacheHelper.PutBoolean('isDark', isDark).then((value) => emit(ToggleMode()));
    }
  }


}
