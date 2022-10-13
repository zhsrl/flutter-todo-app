import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'consts.dart';

class ChangeAvatar extends StatefulWidget {
  ChangeAvatar({Key? key}) : super(key: key);

  @override
  State<ChangeAvatar> createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  var selectedImage;

  Future getImageFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    final storageRef = FirebaseStorage.instance;

    final imageRef = storageRef
        .ref()
        .child("images")
        .child(FirebaseAuth.instance.currentUser!.uid.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Avatar',
              style: TextStyle(
                color: AppColor.white,
                fontSize: 32,
              )),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 100,
                  width: 300,
                  child: ListView.separated(
                      itemCount: maleImages.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 20);
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  maleImages[index],
                                )),
                            Positioned(
                              bottom: -20.0,
                              child: Radio(
                                value: maleImages[index],
                                groupValue: selectedImage,
                                onChanged: (value) {
                                  setState(() {
                                    selectedImage = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ));
                      }),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                      itemCount: femaleImages.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 20);
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: Stack(
                          clipBehavior: Clip.antiAlias,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  femaleImages[index],
                                )),
                            Positioned(
                              bottom: -20,
                              child: Radio(
                                value: femaleImages[index],
                                groupValue: selectedImage,
                                onChanged: (value) {
                                  selectedImage = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ));
                      }),
                ),
              )
            ],
          ),
          SizedBox(
            height: fullHeight * 0.05,
          ),
          SizedBox(
            width: fullWidth,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                String imageName = 'test_avatar';
                String imagePath = 'avatars/';

                final Directory systemDir = Directory.systemTemp;
                final byteData = await rootBundle.load(maleImages[1]);

                File f = File('${systemDir.path}/$imageName.png');

                await f.writeAsBytes(byteData.buffer.asUint8List(
                    byteData.offsetInBytes, byteData.lengthInBytes));
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
              child: Text('Select',
                  style: TextStyle(
                      color: AppColor.dark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
