import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsynews/layout/cubit/cubit.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/shared/AppCubit/cubit.dart';
import 'package:newsynews/shared/components/components.dart';

class Buisness_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var businesslist = NewsCubit.get(context).Get_Business;
        return businesslist.length == 0 ?  Center(child: CircularProgressIndicator()) :
        NewsCubit.get(context).Error != '' ?Text('Please Open The Internet On Your Device!') :
        RefreshIndicator(
          color: WholeAppCubit.get(context).isDark ? Colors.black87 : Colors.blue[200],
          backgroundColor: Colors.grey,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => BuildArticleItem(businesslist[index],context,businesslist[index]['url']),
              separatorBuilder: (context,index) => MyDivider() ,
              itemCount:15
            ),
          onRefresh: ()async{
            return await NewsCubit.get(context).get_business();
          },
        );
        },
    );
  }
}