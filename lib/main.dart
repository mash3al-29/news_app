import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/shared/AppCubit/cubit.dart';
import 'package:newsynews/shared/AppCubit/states.dart';
import 'package:newsynews/shared/Bloc_Observer.dart';
import 'package:newsynews/shared/network/local/cache_helper.dart';
import 'package:newsynews/shared/network/remote/Dio_Helper.dart';

import 'layout/cubit/cubit.dart';
import 'layout/news_layout.dart';
import 'modules/Search_Module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.GetBoolean('isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..get_business()),
        BlocProvider(create: (context) => WholeAppCubit()..Toggle(FromShared: isDark)),
      ],
      child: BlocConsumer<WholeAppCubit,AppCubitStates>(
        listener: (context,state) {},
        builder: (context,state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),bodyText2: TextStyle(color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,),
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 50,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue[200],
              backgroundColor: Colors.white,
            ),
            appBarTheme: AppBarTheme(
              titleSpacing: 20,
                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blue[200],
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 15,
                )
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.lightBlue,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              bodyText2: TextStyle(color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,),
            ),
            scaffoldBackgroundColor: HexColor('333739'),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 50,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue[200],
              backgroundColor: HexColor('333739'),
            ),
            appBarTheme: AppBarTheme(
              titleSpacing: 20,
                backgroundColor: HexColor('333739'),
                backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 15,
                )
            ),

          ),
          themeMode: WholeAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: Directionality(
              textDirection: TextDirection.ltr,
              child: news_layout()),
        ),
      ),
    );

  }
}
