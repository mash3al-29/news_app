import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsynews/layout/cubit/cubit.dart';
import 'package:newsynews/layout/cubit/states.dart';
import 'package:newsynews/shared/components/components.dart';

class Search_Module extends StatelessWidget {
  var SearchController = TextEditingController();
  Function Validator =(value) {
    if (value.isEmpty) {
      return 'Please Enter A Search Term';
    }
    return null;
  };
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: FormKey,
      child: BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state) {
          var Searchlist =NewsCubit.get(context).Get_Search;
          return  Scaffold(
          appBar: AppBar(
            title: Text('News App',),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultTextFormField(
                  ChangeFunction : (value){
                    NewsCubit.get(context).search(value);
                  },
                  controller: SearchController,
                  type: TextInputType.text,
                  LabelText: 'Search',
                  validate: Validator,
                  prefixicon: Icons.search,
                ),
              ),
                Expanded(
                  child: Searchlist.length == 0 ? Center(child: Text('Please Add Some Search Terms!')) :
                  NewsCubit.get(context).Error == "DioError [DioErrorType.other]: SocketException: Failed host lookup: 'newsapi.org' (OS Error: No address associated with hostname, errno = 7)" ?
                  Text('Please Open Your Internet and Refresh The Screen!') :
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) =>
                          BuildArticleItem(Searchlist[index],context,Searchlist[index]['url']),
                      separatorBuilder: (context,index) => MyDivider(),
                      itemCount: 15,
                  ),
                ),
            ],
          ),
        );
          },
      ),
    );
  }
}
