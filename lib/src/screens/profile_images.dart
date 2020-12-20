import 'dart:convert';
import 'dart:io';

import 'package:balloons/src/screens/home.dart';
import 'package:balloons/src/screens/profile_full_image.dart';
import 'package:balloons/src/utils/Strings.dart';
import 'package:balloons/src/utils/colors.dart';
import 'package:balloons/src/utils/helper.dart';
import 'package:balloons/src/utils/styles.dart';
import 'package:balloons/src/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImage extends StatefulWidget {
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  Styles _styles;
  List<File> imagesList;
  File img1, img2, img3, img4, img5, img6;
  String tag1 ,tag2, tag3, tag4,tag5, tag6;
  List<String> tagList;
  int currentIndex = -1;
  String token;
  Helper _helper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _styles = new Styles();
    imagesList = new List();
    tagList = new List();
    imagesList.add(img1);
    imagesList.add(img2);
    imagesList.add(img3);
    imagesList.add(img4);
    imagesList.add(img5);
    imagesList.add(img6);

    tagList.add(tag1);
    tagList.add(tag2);
    tagList.add(tag3);
    tagList.add(tag4);
    tagList.add(tag5);
    tagList.add(tag6);

    _helper = new Helper();

    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: mainLayout(),),
    );
  }

  Widget mainLayout() {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              Container(margin: EdgeInsets.only(left: 10),child: Text("Upload Images", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
              SizedBox(height: 20,),
              Container(
                child: GridView.count(crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: (1/1.3),
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(6, (index){
                  return _profileImage1(index);
                }),)
              ),

              SizedBox(height: 40,),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _continueButton(),
                      Text(Strings.skip, style: TextStyle(fontSize: 16, color: AppColor.colorPrimaryDark),)
                    ],
                  ),
              ),
            ],
          ),
        ));
  }

  Widget _profileImage1(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              currentIndex = index;
              _optionsDialogBox();
            },
            child: imagesList.elementAt(index) == null?Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColor.light_grey,
                  border: new Border.all(
                    width: 2.0,
                    color: AppColor.light_grey,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  )
              ),
              child: Center(child: Icon(Icons.add,color: AppColor.white,size: 70,),),
            ):Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(imagesList.elementAt(index)),
                      fit: BoxFit.fill
                  ),
                  color: AppColor.light_grey,
                  border: new Border.all(
                    width: 2.0,
                    color: AppColor.light_grey,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  )
              ),
            ),
          ),
          Visibility(visible: imagesList.elementAt(index)!= null,child: InkWell(onTap: (){_cancelImg(index);},child: Icon(Icons.cancel, color: AppColor.colorPrimaryDark,))),
          Visibility(
            visible: imagesList.elementAt(index) != null,
            child: Positioned(
              bottom: 0.0,
              width: 100,
              child: Center(
                child: Container(
                  height: 20,
                 width: double.infinity,
                 margin: EdgeInsets.only(left: 5),
                 child: RaisedButton(
                   shape: _styles.buttonRounded(18.0, AppColor.colorPrimaryDark),
                   color: AppColor.colorPrimaryDark,
                   onPressed: (){
                   },
                   child: Text(tagList.elementAt(index)??'',
                   style: TextStyle(fontSize: 12, color: AppColor.white),),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _optionsDialogBox() {
    return showDialog(context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Take a picture'),
                        Icon(Icons.camera_alt,
                          color: AppColor.colorPrimary,)
                      ],
                    ),
                    onTap: openCamera,
                  ),

                  SizedBox(height: 20,),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Select from gallery'),
                        Icon(Icons.image,
                          color: AppColor.colorPrimary,)
                      ],
                    ),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openGallery() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000.0,
        maxHeight: 1000.0,
        imageQuality: 90
    );
    if(img == null) return;

  final data = await  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ProfileFullImage(img)))??"";
    Navigator.of(context).pop();
    imagesList[currentIndex] = img;
    tagList[currentIndex] = data;
    _uploadImage(img);
    setState(() {});
    print(data);

  }

  void openCamera() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000.0,
        maxHeight: 1000.0,
        imageQuality: 90
    );

    if(img == null)return;

    final data = await  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ProfileFullImage(img)))??"";
    Navigator.of(context).pop();

    imagesList[currentIndex] = img;
    tagList[currentIndex] = data;

    _uploadImage(img);

    setState(() {});
    print(data);

  }

  Widget _continueButton(){
    return Container(
      width: 180,
      height: 40,
      child: RaisedButton(
        onPressed: (){},
        color: AppColor.colorPrimaryDark,
        shape: _styles.buttonRounded(18.0, AppColor.colorPrimaryDark),
        child: Text(Strings.upload, style: TextStyle(color: AppColor.white),),
      ),
    );
  }

  void _cancelImg(int index){
    imagesList[index] = null;
    tagList[index] =  null;
    setState(() {

    });
  }

  void _uploadImage(var image)async{

    if(token == null) return;

    var postUri = Uri.parse(Urls.UPLOAD_IMAGE+ token);

    print(postUri.toString());

    var request = new http.MultipartRequest("POST", postUri);

    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length =  await image.length();
    var multipartFile = new http.MultipartFile('image', stream, length, filename:Path.basename(image.path));
    request.files.add(multipartFile);

    var response = await request.send();

    print(response.statusCode);

    final contents = StringBuffer();

    response.stream.transform(utf8.decoder).listen((value) {
      contents.write(value);
    }, onDone: (){

      var response = json.decode(contents.toString());

      print(response);

      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> HomeScreen()));
      //
    });

  }

  void getSharedPreferences() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString(Strings.token);
  }
}
