import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:LAWTALK/controllers/image-uploads/image_uploads_bloc.dart';

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
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<ImageUploadsBloc>(context)
                      .add(PickImage(source: ImageSource.camera)),
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
}
