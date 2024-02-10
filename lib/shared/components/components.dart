import 'package:flutter/material.dart';
import 'package:newsynews/modules/WebView_Screen.dart';

Widget BuildArticleItem(article,context,String url,)  {
  var DateList = article['publishedAt'].split('T');
  var Date = DateList[0];
  var TimeList = DateList[1];
  var Time = TimeList.split('Z');
  var Time1 = Time[0].split(':');
  var Time2 ='${Time1[0]}:${Time1[1]}';
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>WebView_Screen(
        url
      )));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image:  NetworkImage(
                  article['urlToImage'] == null ? 'https://yt3.ggpht.com/ytc/AAUvwnhqxIOAZQ5sa7VtGMUpY3lmRO8tMHDidWx0oqkr=s900-c-k-c0x00ffffff-no-rj'  : '${article['urlToImage']}',

                ),
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,),
                  ),
                  Row(
                    children: [
                      Text('$Date',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),),
                      SizedBox(width: 8,),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 5,
                      ),
                      SizedBox(width: 8,),
                      Text('$Time2',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),),
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget MyDivider(){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(width: double.infinity,color: Colors.grey ,height: 2,),
  );
}

Widget DefaultButton({
  bool isUpperCase = false,
  double width = double.infinity,
  Color color = Colors.tealAccent,
  double radius = 0.0,
  @required Function function,
  @required String text,
  double elevation = 20,
  Color textColor = Colors.white,
}) => Container(

  width: width,
  height: 40,
  decoration: BoxDecoration(
    borderRadius: BorderRadiusDirectional.circular(radius),
    color: color,
  ),
  child: MaterialButton(
    elevation: elevation,
    height: 40,
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: textColor,
      ),
    ),
  ),
);

Widget DefaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String LabelText,
  Function SubmitFunction,
  Function ChangeFunction,
  IconData prefixicon,
  @required Function validate,
  IconData SufixIcon,
  bool isObscure = false,
  Function isSuffixpressed,
  Function onTap,
  bool enabled,
}) => TextFormField(
  controller: controller,
  onFieldSubmitted: SubmitFunction,
  onChanged: ChangeFunction ,
  enabled: enabled,
  keyboardType: type ,
  obscureText: isObscure,
  onTap: onTap,
  decoration: InputDecoration(
    labelText: LabelText,
    prefixIcon: Icon(
      prefixicon,
    ),
    suffixIcon: SufixIcon!= null ? IconButton(icon : Icon(SufixIcon),onPressed: isSuffixpressed, ): null,
    border: OutlineInputBorder(),
  ),
  validator: validate,
);
