import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsynews/layout/cubit/cubit.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/shared/AppCubit/cubit.dart';
import 'package:newsynews/shared/components/components.dart';

class Science_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var sciencelist = NewsCubit.get(context).Get_Science;
        return sciencelist.length == 0 ?  Center(child: CircularProgressIndicator()) :
        NewsCubit.get(context).Error != ''  ?
        Text('Please Open Your Internet and Refresh The Screen!') :
        RefreshIndicator(
          color:  WholeAppCubit.get(context).isDark ? Colors.black87 : Colors.blue[200],
            backgroundColor: Colors.grey,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => BuildArticleItem(sciencelist[index],context,sciencelist[index]['url']),
              separatorBuilder: (context,index) => MyDivider() ,
              itemCount:15),
            onRefresh: () async {
              return await NewsCubit.get(context).get_science();
            }
        );
      },
    );
  }
}
