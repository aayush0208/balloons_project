import 'dart:io';

import 'package:balloons/src/utils/colors.dart';
import 'package:balloons/src/utils/styles.dart';
import 'package:flutter/material.dart';

class ProfileFullImage extends StatefulWidget {

  File image;

  ProfileFullImage(this.image);

  @override
  _ProfileFullImageState createState() => _ProfileFullImageState();
}

class _ProfileFullImageState extends State<ProfileFullImage> {

  Styles _styles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _styles = new Styles();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            Center(
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black26, Colors.black26],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.darken,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(widget.image),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                )
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50),
              child: Text("Select Tag", textAlign: TextAlign.center,style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold,
              fontSize: 24),),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Wrap(
                children: [
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 40,
                      margin: EdgeInsets.all(5.0),
                      decoration: _styles.tagBorder(),
                      child: Center(child: Text("Tag1",style: TextStyle(color: AppColor.white),)),
                    ),
                    onTap: (){
                      _sendTag("Tag 1");
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 40,
                      margin: EdgeInsets.all(5.0),
                      decoration: _styles.tagBorder(),
                      child: Center(child: Text("Tag2",style: TextStyle(color: AppColor.white),)),
                    ),
                    onTap: (){
                      _sendTag("Tag 2");
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 40,
                      margin: EdgeInsets.all(5.0),
                      decoration: _styles.tagBorder(),
                      child: Center(child: Text("Tag3",style: TextStyle(color: AppColor.white),)),
                    ),
                    onTap: (){
                      _sendTag("Tag 3");
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 40,
                      margin: EdgeInsets.all(5.0),
                      decoration: _styles.tagBorder(),
                      child: Center(child: Text("Tag4",style: TextStyle(color: AppColor.white),)),
                    ),
                    onTap: (){
                      _sendTag("Tag 4");
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 40,
                      margin: EdgeInsets.all(5.0),
                      decoration: _styles.tagBorder(),
                      child: Center(child: Text("Tag5",style: TextStyle(color: AppColor.white),)),
                    ),
                    onTap: (){
                      _sendTag("Tag 5");
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 40,
                      margin: EdgeInsets.all(5.0),
                      decoration: _styles.tagBorder(),
                      child: Center(child: Text("Tag6",style: TextStyle(color: AppColor.white),)),
                    ),
                    onTap: (){
                      _sendTag("Tag 6");
                    },
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  void _sendTag(String tag){
    Navigator.pop(context, tag);
  }
}
