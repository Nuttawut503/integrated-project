import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:LAWTALK/controllers/image-uploads/image_uploads_bloc.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LawyerImageUploadScreen extends StatefulWidget {
  final Map _currentUser;

  LawyerImageUploadScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _LawyerImageUploadScreenState createState() =>
      _LawyerImageUploadScreenState();
}

class _LawyerImageUploadScreenState extends State<LawyerImageUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify')),
      backgroundColor: Color.fromRGBO(50, 55, 69, 1),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => BlocProvider.of<ImageUploadsBloc>(context)
                    .add(PickImage(source: ImageSource.camera))),
            SizedBox(
              width: 100,
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => BlocProvider.of<ImageUploadsBloc>(context)
                  .add(PickImage(source: ImageSource.gallery)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ImageUploadsBloc, ImageUploadsState>(
            builder: (context, state) {
          return Container(
            // width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  if (state is PickedImage && state.imageFile != null) ...[
                    Container(
                        height: 400,
                        child: Image.file(File(state.imageFile.path))),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.crop),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Crop'),
                            ],
                          ),
                          color: Colors.pinkAccent,
                          onPressed: () =>
                              BlocProvider.of<ImageUploadsBloc>(context)
                                  .add(CropImage()),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.clear),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Delete'),
                            ],
                          ),
                          color: Colors.indigo,
                          onPressed: () =>
                              BlocProvider.of<ImageUploadsBloc>(context)
                                  .add(ClearImage()),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.blue,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add'),
                            ],
                          ),
                          onPressed: () {
                            _addMore(File(state.imageFile.path));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ] else if (state is CropedImage &&
                      state.imageFile != null) ...[
                    Container(height: 400, child: Image.file(state.imageFile)),
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
                        SizedBox(
                          width: 30,
                        ),
                        FlatButton(
                          color: Colors.blue,
                          child: Icon(Icons.add),
                          onPressed: () =>
                              BlocProvider.of<ImageUploadsBloc>(context)
                                  .add(ClearImage()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
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
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ] else ...[
                    // Center(
                    //   child: Text('You\'re almost there!',
                    //       style: GoogleFonts.openSans(
                    //           color: Colors.white, fontSize: 30)),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        'Please take a picture or browse gallery of your citizen ID card and career evidences',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _addMore(File image) async {
    final databaseReference = Firestore.instance;
    StorageReference profilePictureStorage = FirebaseStorage.instance
        .ref()
        .child('profile_pic/${DateTime.now()}.png');
    StorageUploadTask uploadTask = profilePictureStorage.putFile(image);

    final uploadedLink =
        (await (await uploadTask.onComplete).ref.getDownloadURL());
    print(uploadedLink);
    try {
      databaseReference
          .collection('registered_user')
          .document('${widget._currentUser['id']}')
          .updateData({
        'lawyer_picture': FieldValue.arrayUnion(['$uploadedLink']),
      });
    } catch (e) {
      print(e.toString());
    }
    Navigator.pop(context);
    BlocProvider.of<ImageUploadsBloc>(context).add(ClearImage());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LawyerImageUploadScreen(
                  currentUser: widget._currentUser,
                )));
  }

  void _submit(File image) async {
    final databaseReference = Firestore.instance;
    StorageReference profilePictureStorage = FirebaseStorage.instance
        .ref()
        .child('profile_pic/${DateTime.now()}.png');
    StorageUploadTask uploadTask = profilePictureStorage.putFile(image);

    final uploadedLink =
        (await (await uploadTask.onComplete).ref.getDownloadURL());
    print(uploadedLink);
    try {
      databaseReference
          .collection('registered_user')
          .document('${widget._currentUser['id']}')
          .updateData({
        'isVerified': true,
        'lawyer_picture': FieldValue.arrayUnion(['$uploadedLink']),
        'isLawyer': true,
      });
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }
}
