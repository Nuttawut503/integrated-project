import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:LAWTALK/controllers/image-uploads/image_uploads_bloc.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUploadScreen extends StatefulWidget {
  final Map _currentUser;

  ImageUploadScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<ImageUploadsBloc, ImageUploadsState>(
            builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Helooo',
                  style: GoogleFonts.openSans(color: Colors.white),
                ),
                Text(
                  '${state.toString()}',
                  style: GoogleFonts.openSans(color: Colors.white),
                ),
                if (state is PickedImage && state.imageFile != null) ...[
                  Container(
                      height: 400,
                      child: Image.file(File(state.imageFile.path))),
                  Text(
                    'Hello',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.crop),
                        color: Colors.pinkAccent,
                        onPressed: () =>
                            BlocProvider.of<ImageUploadsBloc>(context)
                                .add(CropImage()),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      FlatButton(
                        child: Icon(Icons.refresh),
                        color: Colors.indigo,
                        onPressed: () =>
                            BlocProvider.of<ImageUploadsBloc>(context)
                                .add(ClearImage()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _submit(File(state.imageFile.path));
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ] else if (state is CropedImage && state.imageFile != null) ...[
                  Container(height: 400, child: Image.file(state.imageFile)),
                  Text(
                    'Hello',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.pinkAccent,
                        child: Icon(Icons.crop),
                        onPressed: () =>
                            BlocProvider.of<ImageUploadsBloc>(context)
                                .add(CropImage()),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      FlatButton(
                        color: Colors.indigoAccent,
                        child: Icon(Icons.refresh),
                        onPressed: () =>
                            BlocProvider.of<ImageUploadsBloc>(context)
                                .add(ClearImage()),
                      ),
                    ],
                  )
                ],
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.camera_alt),
                  onPressed: () => BlocProvider.of<ImageUploadsBloc>(context)
                      .add(PickImage(source: ImageSource.camera)),
                ),
                // FloatingActionButton(
                //   child: Icon(Icons.image),
                //   onPressed: () => BlocProvider.of<ImageUploadsBloc>(context)
                //       .add(PickImage(source: ImageSource.gallery)),
                // ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<ImageUploadsBloc>(context)
                        .add(PickImage(source: ImageSource.gallery));
                  },
                  child: Text(
                    'Browse gallery',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  color: Colors.indigoAccent,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _submit(File image) async {
    final databaseReference = Firestore.instance;
    StorageReference profilePictureStorage =
        FirebaseStorage.instance.ref().child('profile_pic/file_name');
    StorageUploadTask uploadTask = profilePictureStorage.putFile(image);

    final uploadedLink =
        (await (await uploadTask.onComplete).ref.getDownloadURL());
    print(uploadedLink);
    try {
      databaseReference
          .collection('registered_user')
          .document('${widget._currentUser['id']}')
          .updateData({'isVerified': true, 'citizen_picture': '$uploadedLink'});
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }
}
