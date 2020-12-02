import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:m1/app_core/app_core.dart';
import 'dart:typed_data';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:animate_do/animate_do.dart';
import 'package:m1/features/home/home_page.dart';
import 'package:m1/features/sign_up/sign_up_manager.dart';


class Tab {
  String title;
  int id;
  Tab(this.title,this.id);
}


class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  List <Tab>tabs = [
    Tab("Location",0),
    Tab("Account",1),
    Tab("Verity",2),
  ];

  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];



  @override
  void initState() {
    // String apiKey = DotEnv().env['https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I&input=vodafone%20international&language=en&components=country%3Aeg&types=establishment'];
    googlePlace = GooglePlace('AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var HomeManger = context.use<SignUpManager>();
    List views = [
      locationWidget(),
      accountWidget(),
      verfiyWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: (){},
          child: Icon(Icons.keyboard_backspace,color: Color(0xffd95265)),
        ),
        centerTitle: true,
        title: Text("Sign Up",style: TextStyle(color: Color(0xffd95265)),),
        actions: [
          BounceInDown(
            child: InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  new Container(
                    height: 40,
                    width: 85,
                    child: Center(child: Text("Sign In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        gradient: LinearGradient(
                          colors : [
                            Color(0xffedb147),
                            Color(0xffeeb646),
                            Color(0xfff1cf4d),
                          ],begin: Alignment.centerRight,end: Alignment.centerLeft,

)),
                  ),
                  SizedBox(width: 10.0,)
                ],
              ),
            ),
          )
        ],
      ),
      body:
      StreamBuilder(
        initialData: 0,
        stream: HomeManger.tabs.stream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,),
                Container(
                  height: 50,
                // color: Colors.red,
                child: ListView(
                  children: tabs.map((e) => InkWell(
                    onTap: (){
                      HomeManger.tabs.add(e.id);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Text(e.title,style: TextStyle(
                            color: snapshot.data == e.id ? Color(0xffd95265) : Color(0xffc8ccda),
                            fontSize: 16
                          ),),
                          SizedBox(height: 5,),
                          Container(
                            width: 80,
                            height: 3,
                            decoration: BoxDecoration(
                              color:snapshot.data == e.id ? Color(0xffd95265) : Color(0xffc8ccda),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        ],
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  )).toList(),
                  scrollDirection: Axis.horizontal,

                ),),
                Expanded(child: views[snapshot.data]),


              ],
            ),
          );
        }
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );

  }
  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value,components:[Component("country", "eg")],language: "en",types:"establishment");
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  Widget locationWidget(){
    return FadeIn(
      key: Key("1"),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset("assets/images/icn_company.png"),
                ),
                SizedBox(width: 8,),
                Text("Set your work location",style: TextStyle(color: Color(0xff727a8a),fontSize: 16,fontWeight: FontWeight.w600),)
              ],
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xffd95265),width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      // keyboardType: inputType,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        // hintText: "sLabel",
                        labelText: "Work Address",
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {
                          if (predictions.length > 0 && mounted) {
                            setState(() {
                              predictions = [];
                            });
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset("assets/images/icn_search.png"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:Icon(Icons.location_on_rounded,size: 25,),
                    title: Text(predictions[index].structuredFormatting.mainText,style: TextStyle(color: Color(0xff52b5bd),fontWeight: FontWeight.w800,fontSize: 16),),
                    subtitle: Text(predictions[index].structuredFormatting.secondaryText,style: TextStyle(color: Color(0xffafb3bd),fontWeight: FontWeight.w800,fontSize: 14),),
                    onTap: () {
                      debugPrint(predictions[index].placeId);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailsPage(
                      //       placeId: predictions[index].placeId,
                      //       googlePlace: googlePlace,
                      //     ),
                      //   ),);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                          ),
                        ),);
                    },
                  );
                },
              ),
            ),
          ]
      ),
    );
  }

  Widget accountWidget(){
    return FadeIn(
      key: Key("2"),

      child: Center(
        child: Text("Account",style: TextStyle(fontSize: 26),),
      ),
    );
  }
  Widget verfiyWidget(){
    return FadeIn(
      key: Key("3"),

      child: Center(
        child: Text("verfiy",style: TextStyle(fontSize: 26),),
      ),
    );
  }

}




class DetailsPage extends StatefulWidget {
  final String placeId;
  final GooglePlace googlePlace;

  DetailsPage({Key key, this.placeId, this.googlePlace}) : super(key: key);

  @override
  _DetailsPageState createState() =>
      _DetailsPageState(this.placeId, this.googlePlace);
}

class _DetailsPageState extends State<DetailsPage> {
  final String placeId;
  final GooglePlace googlePlace;

  _DetailsPageState(this.placeId, this.googlePlace);

  DetailsResult detailsResult;
  List<Uint8List> images = [];
  // BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    getDetils(this.placeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          getDetils(this.placeId);
        },
        child: Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.memory(
                            images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      detailsResult != null && detailsResult.types != null
                          ? Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: detailsResult.types.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Chip(
                                label: Text(
                                  detailsResult.types[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.blueAccent,
                              ),
                            );
                          },
                        ),
                      )
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_on),
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.formattedAddress != null
                                ? 'Address: ${detailsResult.name}'
                                : "Address: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_searching),
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.geometry != null &&
                                detailsResult.geometry.location != null
                                ? 'Geometry: ${detailsResult.geometry.location.lat.toString()},${detailsResult.geometry.location.lng.toString()}'
                                : "Geometry: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.timelapse),
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.utcOffset != null
                                ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
                                : "UTC offset: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.rate_review),
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.rating != null
                                ? 'Rating: ${detailsResult.rating.toString()}'
                                : "Rating: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.attach_money),
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.priceLevel != null
                                ? 'Price level: ${detailsResult.priceLevel.toString()}'
                                : "Price level: null",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset("assets/powered_by_google.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDetils(String placeId) async {
    var result = await this.googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result;
        images = [];
      });
print("detailsResult${detailsResult}");
      if (result.result.photos != null) {
        for (var photo in result.result.photos) {
          getPhoto(photo.photoReference);
        }
      }
    }
  }

  void getPhoto(String photoReference) async {
    var result = await this.googlePlace.photos.get(photoReference, null, 400);
    if (result != null && mounted) {
      setState(() {
        images.add(result);
      });
    }
  }
}

class dddd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
