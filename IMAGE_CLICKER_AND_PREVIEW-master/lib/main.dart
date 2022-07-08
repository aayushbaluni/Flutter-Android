import 'dart:io';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   final cameras=await availableCameras();
   final firstcamera=cameras.first;
   runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
        home: Camerapreview(
          camera: firstcamera,
        ),
     ),
   );
}

class Camerapreview extends StatefulWidget {
  final CameraDescription camera;
  const Camerapreview({Key? key,required this.camera}) : super(key: key);

  @override
  _CamerapreviewState createState() => _CamerapreviewState();
}

class _CamerapreviewState extends State<Camerapreview> {
  late final CameraController cameraController;
 late Future<void> cameraInitializer;
 @override
  void initState() {

    super.initState();
    cameraController=CameraController(widget.camera, ResolutionPreset.medium);
    cameraInitializer =cameraController.initialize();
  }
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Click Picture",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: cameraInitializer,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return CameraPreview(cameraController);
          }else{
            return CircularProgressIndicator(
              color: Colors.teal,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          try{
            await cameraInitializer;
            final image=await cameraController.takePicture();
            Navigator.of(context).push( MaterialPageRoute(builder: (context)=>Imageshow(
                imagepath: image.path,
            )
            ));

          }catch(e){
            print(e);
          }

        },
      ),
    ) ;
  }
}

class Imageshow extends StatelessWidget {
  final String imagepath;
  const Imageshow({Key? key,required this.imagepath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: Image.file(
                  File(imagepath)
              ),
          ),
      ),floatingActionButton: FloatingActionButton(
      onPressed: ()async{
        try{
          await GallerySaver.saveImage(imagepath);
        print("Saved Successfully!");
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("Saved Successfully",style: TextStyle(color: Colors.black,fontSize: 20,),),
          );
        }catch (e){
          print(e);
        Text('Cannot save Image...try again');
        }
    },
    ),
    );
  }
}

