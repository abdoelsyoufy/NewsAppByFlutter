import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget newsDesign(articl,mod,context){
  List<String> dateTime= articl['publishedAt'].toString().split('T');

  int hour = int.parse(dateTime[1].substring(0,2));
  if(hour>12)
    {
      hour%=12;
      dateTime[1] = dateTime[1].replaceFirst(RegExp('Z'), ' pm');
    }
  else
    {
      dateTime[1] =dateTime[1].replaceFirst(RegExp('Z'), ' am');
    }
  return InkWell(
  onTap: () {
    Navigator.push(context ,
        MaterialPageRoute(builder:(context) => WebViewScreen(url: articl['url'],),)
    );
  },
  child:   Padding(

    padding: const EdgeInsets.all(15.0),

    child: Row(

      children: [

        Container(

          width: 120,
          height: 120,
          decoration: BoxDecoration(
               image: DecorationImage(
                 image: NetworkImage(articl['urlToImage']==null?

                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGTFs4nU9FxpIRv6hi-mDG_E3MsEIiWpO8Xg&usqp=CAU':articl['urlToImage']

                 ),
                 fit: BoxFit.cover

               ),
              borderRadius: BorderRadius.circular(20)

          ),
        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Expanded(

                  child: Directionality(



                    textDirection:TextDirection.rtl ,

                    child: Text(

                      '${articl['title']}',

                      style: mod?TextStyle(

                          color: Colors.white,

                        fontSize: 18,

                        fontWeight: FontWeight.w600

                      ):

                      TextStyle(

                          color: Colors.black,

                          fontSize: 18,

                          fontWeight: FontWeight.w600

                      ),

                      maxLines: 3,

                      overflow: TextOverflow.clip,

                    ),

                  ),

                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(

                         dateTime[0],

                        style: TextStyle(

                            fontWeight: FontWeight.w600,

                            color: Colors.grey[600],

                            fontSize: 16

                        ),

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                      ),
                    ),
                    Text(

                      '$hour ${dateTime[1].substring(2)}',

                      style: TextStyle(

                          fontWeight: FontWeight.w600,

                          color: Colors.grey[600],

                          fontSize: 16

                      ),

                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,

                    ),
                  ],
                )

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);
}

Widget articlesBuilder(List articles,bool mode)=> ConditionalBuilder(
  condition: articles.length>0,
  builder: (context) => ListView.separated(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => newsDesign(articles[index],mode,context),
      separatorBuilder:(context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 15),
        child: Container(
          height: 1,
          color: Colors.grey,

        ),
      ) ,
      itemCount: articles.length
  ),
  fallback: (context) =>Center(child: CircularProgressIndicator()) ,
);


Widget defaultTextFormField({
  @required String  hintText ,
  IconData prefixIcon,
  IconData  suffixIcon,
  bool isPassword = false,
  @required Function functionValidator,
  @required TextEditingController  controller,
  @required  TextInputType inputType,
  Function  suffixClick,
  Function  onTap,
  Function onChanged,
})
{

  return  TextFormField(
    keyboardType: inputType,
    controller: controller,
    obscureText: isPassword,
    validator: functionValidator,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: hintText,
      border: OutlineInputBorder(),
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixClick,
      ),


    ),
    onChanged: onChanged,
    // style: NewsCubit().isDark==false?TextStyle(color: Colors.white,fontSize: 18):TextStyle(color: Colors.black,fontSize: 18),



  );
}