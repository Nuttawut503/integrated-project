import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:LAWTALK/view/upload_image_screen.dart';

class UserVerifyScreen extends StatefulWidget {
  final Map _currentUser;

  UserVerifyScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _UserVerifyScreenState createState() => _UserVerifyScreenState();
}

class _UserVerifyScreenState extends State<UserVerifyScreen> {
  final databaseReference = Firestore.instance;
  final formKey = GlobalKey<FormState>();
  String _firstName, _lastName, _address, _occupation;
  int _citizenID, _phoneNo;

  @override
  Widget build(BuildContext context) {
    print(widget._currentUser['email']);
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            _validate();
          },
          child: Container(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Center(
                child: ListView(
                  padding: EdgeInsets.all(30),
                  shrinkWrap: true,
                  children: <Widget>[
                    firstNameField(),
                    lastNameField(),
                    addressField(),
                    phoneField(),
                    occupationField(),
                    citizenIDField(),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: () {
                          _createRecord();
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        color: Colors.indigoAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'First name', hintText: 'Enter first name here'),
      keyboardType: TextInputType.text,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
      ],
      maxLength: 30,
      validator: (input) => input.isEmpty ? 'Pleae enter your name' : null,
      onSaved: (input) => _firstName = input,
      onTap: () => _validate(),
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Last name', hintText: 'Enter last name here'),
      keyboardType: TextInputType.text,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
      ],
      maxLength: 30,
      validator: (input) => input.isEmpty ? 'Pleae enter your name' : null,
      onSaved: (input) => _lastName = input,
      onTap: () => _validate(),
    );
  }

  Widget addressField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Address', hintText: 'Enter your address here'),
      keyboardType: TextInputType.text,
      inputFormatters: [
        // WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
      ],
      maxLength: 70,
      validator: (input) => input.isEmpty ? 'Pleae enter your address' : null,
      onSaved: (input) => _address = input,
      onTap: () => _validate(),
    );
  }

  Widget phoneField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone number', hintText: 'Enter your phone number'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      maxLength: 10,
      validator: (input) => input.length < 10 ? 'Invalid phone number' : null,
      onSaved: (input) => _phoneNo = int.parse(input),
      onTap: () => _validate(),
    );
  }

  Widget occupationField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Occupation', hintText: 'Enter your occupation name here'),
      keyboardType: TextInputType.text,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
      ],
      maxLength: 20,
      validator: (input) =>
          input.isEmpty ? 'Pleae enter your occupation' : null,
      onSaved: (input) => _occupation = input,
      onTap: () => _validate(),
    );
  }

  Widget citizenIDField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Citizen ID',
          hintText: 'Enter your 13 digit citizen ID here'),
      keyboardType: TextInputType.numberWithOptions(),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      maxLength: 13,
      validator: (input) => input.length < 13 ? 'Invalid citizen ID' : null,
      onSaved: (input) => _citizenID = int.parse(input),
      onTap: () => _validate(),
    );
  }

  void _validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(_firstName);
    }
  }

  void _createRecord() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        print('---------------------------------------------------------');
        print(widget._currentUser.toString());
        print('---------------------------------------------------------');

        await databaseReference
            .collection("registered_user")
            .document('${widget._currentUser['id']}')
            .setData({
          'email': '${widget._currentUser['email']}',
          'first_name': '$_firstName',
          'last_name': '$_lastName',
          'address': '$_address',
          'phone': '$_phoneNo',
          'occupation': '$_occupation',
          'citizenID': '$_citizenID',
          'citizen_picture': null,
          'isVerified': false,
          'isLawyer': false,
          'lawyer_picture': null
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ImageUploadScreen(currentUser: widget._currentUser)));
      } catch (err) {
        print(err);
        throw (err);
      }
    }
  }
}
