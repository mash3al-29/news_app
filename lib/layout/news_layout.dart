import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/modules/Search_Module.dart';
import 'package:newsynews/shared/AppCubit/cubit.dart';
import 'package:newsynews/shared/network/remote/Dio_Helper.dart';

import 'cubit/cubit.dart';

class news_layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
      listener: (context,state){},
      builder: (context,state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                icon: Icon(Icons.search_sharp),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Module()));
                },
                iconSize: 30,
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: (){
                  WholeAppCubit.get(context).Toggle();
                },
                iconSize: 30,
              )
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items: cubit.BottomNavBar,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
