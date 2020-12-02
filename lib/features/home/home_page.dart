import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:m1/app_core/app_core.dart';
import 'package:m1/app_core/listsAll.dart';
import 'package:m1/features/home/home_data.dart';
import 'package:m1/features/home/home_manager.dart';

List <Tab>tabs = [
  Tab("All",0),
  Tab("syami",1),
  Tab("Healthy",2),
];
class Tab {
  String title;
  int id;
  Tab(this.title,this.id);
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var homeManger = context.use<HomeManger>();

    return Scaffold(
     body: Observer(
       manager: homeManger,
       stream: homeManger.getStream(),
       onSuccess: (_, ApiResponse<HomeData> model) {
         print("xXx${light[0]["img"]}");
         return Container(
           padding: EdgeInsets.all(15),
           child: ListView(
             children: [
               SizedBox(
                 height: 15,
               ),
           FadeInDown(
             delay: Duration(milliseconds: 200),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Image.asset("assets/images/icn_delivery.png",width: 30,fit:BoxFit.fill ,),
                     SizedBox(width: 8,),
                     Text("Delivery to",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 16),),
                     SizedBox(width: 8,),
                     Text("STC",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w900,fontSize: 16),),
                     SizedBox(width: 5,),
                     Icon(Icons.expand_more,size: 21,)
                   ],
                 ),
               ),
               SizedBox(height: 25,),
               Row(
                 children: [
                   FadeInDown(
               delay: Duration(milliseconds: 500),child: Image.asset("assets/images/Meal_on_the_go.png",width: MediaQuery.of(context).size.width * .3,fit: BoxFit.fill,)),
                 ],
               ),
               SizedBox(height: 25,),
               FadeInDown(
                   delay: Duration(milliseconds: 800)
                   ,child: Image.asset("assets/images/banner.png",fit: BoxFit.fill,)),
               SizedBox(height: 25,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text("Order By 11:30 Am",style: TextStyle(color: Color(0xffca5f8c),fontWeight: FontWeight.w800,fontSize: 15),),
                       Text("Select your meal",style: TextStyle(color: Color(0xff9096a3),fontWeight: FontWeight.w600,fontSize: 14),)
                     ],
                   )),
                   SizedBox(
                     width: 25,
                   ),
                   Expanded(child:
                   StreamBuilder(
                       initialData: 0,
                       stream: homeManger.tabs,
                       builder: (context, snapshot) {
                         return Container(
                           height: 50,
                           // color: Colors.red,
                           child: ListView(
                             children: tabs.map((e) => InkWell(
                               onTap: (){
                                 homeManger.tabs.add(e.id);
                               },
                               child: Container(
                                 padding: EdgeInsets.only(right: 10,top: 8,bottom: 8),
                                 child:   Container(
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: snapshot.data == e.id ? Color(0xffcd496c):Color(0xffedf1f3),
                                   ),
                                   // height: 10,
                                   padding: EdgeInsets.symmetric(horizontal: 11,),
                                   child: Center(
                                     child: Text(e.title,style: TextStyle(
                                         color: snapshot.data == e.id ? Color(0xfff6f8f9) : Color(0xff7c8392),
                                         fontSize: 15,
                                       fontWeight: FontWeight.w700
                                     ),),
                                   ),
                                 ),
                               ),
                             )).toList(),
                             scrollDirection: Axis.horizontal,

                           ),);
                       }
                   )
                   )
                 ],
               ),
               SizedBox(height: 15,),
               Row(
                 children: [
                   Image.asset("assets/images/title_light.png",fit: BoxFit.fill,),
                 ],
               ),
               SizedBox(height: 20,),
               Container(
                   height: MediaQuery.of(context).size.height * .4,

                   child: ListView.builder(
                       itemCount: light.length,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context, i) {
                         return singleProduct(context,light[i]["img"],
                             light[i]["regular_price"],
                             light[i]["plus_price"],
                             light[i]["name"],
                             light[i]["restaurant"]);}
                   )),


               SizedBox(height: 15,),
               Row(
                 children: [
                   Image.asset("assets/images/title_best_value.png",fit: BoxFit.fill,),
                 ],
               ),
               SizedBox(height: 20,),
               Container(
                   height: MediaQuery.of(context).size.height * .4,

                   child: ListView.builder(
                       itemCount: bestValue.length,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context, i) {
                         return singleProduct(context,bestValue[i]["img"],
                             bestValue[i]["regular_price"],
                             bestValue[i]["plus_price"],
                             bestValue[i]["name"],
                             bestValue[i]["restaurant"]);}
                   )),

               SizedBox(height: 15,),
               Row(
                 children: [
                   Image.asset("assets/images/title_plus.png",fit: BoxFit.fill,),
                 ],
               ),
               SizedBox(height: 20,),
               Container(
                   height: MediaQuery.of(context).size.height * .4,

                   child: ListView.builder(
                       itemCount: plus.length,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context, i) {
                         return singleProduct(context,plus[i]["img"],
                             plus[i]["regular_price"],
                             plus[i]["plus_price"],
                             plus[i]["name"],
                             plus[i]["restaurant"]);}
                   )),


             ],
           ),
         );
       },
     ),
    );
  }
}

Widget singleProduct(context,img,oldPrice,newPrice,title,cat){
  return    Container(
    padding: EdgeInsets.only(right: 15),
    height: MediaQuery.of(context).size.width * .55,
    width: MediaQuery.of(context).size.width * .4,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            img,
            height: MediaQuery.of(context).size.width * .4,
            width: MediaQuery.of(context).size.width * .3,
            fit: BoxFit.fill ,
          ),
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("EGP $oldPrice",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,decoration: TextDecoration.lineThrough,color: Colors.black45),),
          ],
        ),
        SizedBox(height: 8,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/icn_plus.png",fit: BoxFit.fill,width: 37,),
            SizedBox(width: 8,),
            Text("EGP $newPrice",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
          ],
        ),
        SizedBox(height: 8,),
        Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),maxLines: 2,),
        SizedBox(height: 8,),
        Text("$cat",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black45),),

      ],
    ),
  );
}

