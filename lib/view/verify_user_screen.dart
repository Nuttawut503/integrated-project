import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';

class UserVerifyScreen extends StatefulWidget {
  final Map _currentUser;

  UserVerifyScreen({Key key, Map currentUser})
      : _currentUser = currentUser,
        super(key: key);

  @override
  _UserVerifyScreenState createState() => _UserVerifyScreenState();
}

class _UserVerifyScreenState extends State<UserVerifyScreen> {
  final formKey = GlobalKey<FormState>();
  String _firstName, _lastName, _address, _occupation;
  int _citizenID, _phoneNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Center(
              child: ListView(
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
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut());
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Submit',
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
    );
  }

  Widget citizenIDField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Citizen ID',
          hintText: 'Enter your 14 digit citizen ID here'),
      keyboardType: TextInputType.numberWithOptions(),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      maxLength: 14,
      validator: (input) => input.length < 14 ? 'Invalid citizen ID' : null,
      onSaved: (input) => _citizenID = int.parse(input),
    );
  }
}
