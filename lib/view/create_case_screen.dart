import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LAWTALK/authentication/authentication_bloc.dart';
import 'package:LAWTALK/controllers/create-case/create_case_bloc.dart';

class CreateCaseScreen extends StatelessWidget {
  final String _currentUserId;
  
  CreateCaseScreen({Key key, @required String currentUserId})
      : _currentUserId = currentUserId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pop();
        }
      },
      child: BlocProvider<CreateCaseBloc>(
        create: (context) => CreateCaseBloc(userId: _currentUserId),
        child: Scaffold(
          appBar: AppBar(title: Text('', style: GoogleFonts.openSans(),),),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: WillPopScope(
              child: CreateCase(),
              onWillPop: () async {
                return (await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Discard your form ?', style: GoogleFonts.openSans()),
                    content: Text(
                      'your information wouldn\'t be saved',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.w300)
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('cancel', style: GoogleFonts.openSans(color: Colors.grey)),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('discard', style: GoogleFonts.openSans(color: Colors.red)),
                      ),
                    ],
                  ),
                )) ?? false;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CreateCase extends StatefulWidget {
  @override
  _CreateCaseState createState() => _CreateCaseState();
}

class _CreateCaseState extends State<CreateCase> {
  TextEditingController _detailFieldController = TextEditingController();
  TextEditingController _tagFieldController = TextEditingController();
  Timer _debounce;

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _detailFieldController.dispose();
    _tagFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: BlocConsumer<CreateCaseBloc, CreateCaseState>(
        listener: (context, state) async {
          if (state.isSuccess) {
            await successPopup();
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return ListView(
            children: <Widget>[
              Text(' Title', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
              SizedBox(height: 8.0,),
              TextFormField(
                maxLength: 40,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  if (_debounce?.isActive ?? false) _debounce.cancel();
                  _debounce = Timer(Duration(milliseconds: 900), () {
                    BlocProvider.of<CreateCaseBloc>(context).add(TitleUpdated(newTitle: text));
                  });
                },
                style: GoogleFonts.openSans(fontSize: 19.0),
                decoration: InputDecoration(
                  hintText: 'Your problem in short',
                  hintStyle: GoogleFonts.openSans(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 16.0,),
              Text(' Detail', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
              SizedBox(height: 8.0,),
              TextFormField(
                maxLength: 300,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _detailFieldController,
                style: GoogleFonts.openSans(),
                decoration: InputDecoration(
                  hintText: 'Please describe your situation',
                  hintStyle: GoogleFonts.openSans(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 16.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(' Tags (upto 5)', style: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w600), textAlign: TextAlign.left,),
                  SizedBox(width: 8.0),
                  if (state.tags.length < 5)
                    Material(
                      color: Colors.white,
                      shape: CircleBorder(side: BorderSide(width: 1.0, color: Colors.green)),
                      child: InkWell(
                        onTap: state.isSubmitting
                        ? null
                        : () async {
                          String newTag = await addTagPopup();
                          _tagFieldController.clear();
                          if (newTag.isNotEmpty) {
                            BlocProvider.of<CreateCaseBloc>(context).add(TagAdded(tagLabel: newTag));
                          }
                        },
                        splashColor: Colors.black.withOpacity(0.3),
                        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(FontAwesomeIcons.plus, size: 19.0, color: Colors.green,),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.0,),
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 6.0,
                children: [
                  for (int i = 0; i < state.tags.length; ++i)
                    TagBadge(index: i, value: '${state.tags[i]}'),
                ],  
              ),
              SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: state.isSubmitting? Colors.yellow: Colors.blue,
                        onPressed: state.title.isNotEmpty
                        ? () {
                          BlocProvider.of<CreateCaseBloc>(context).add(CaseSubmitted(newDetail: _detailFieldController.text));
                        }: null,
                        child: Text(
                          'SUBMIT${(state.isSubmitting)?'TING...':''}',
                          style: GoogleFonts.openSans(color: (state.isSubmitting)? Colors.black: Colors.white),
                        ),
                      ),
                      if (state.isFailure ?? false)
                        Text('Something went wrong\ncan\'t submit the form', style: GoogleFonts.openSans(color: Colors.red), textAlign: TextAlign.end,),
                    ],
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> successPopup() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your form was submitted', style: GoogleFonts.openSans()),
        content: Text(
          'Thank you for your cooperation',
          style: GoogleFonts.openSans(fontWeight: FontWeight.w300)
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: GoogleFonts.openSans()),
          ),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Future<String> addTagPopup() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tag', style: GoogleFonts.openSans()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Add short text to increase attention',
              style: GoogleFonts.openSans(fontWeight: FontWeight.w300)
            ),
            SizedBox(height: 12.0,),
            TextFormField(
              maxLength: 20,
              keyboardType: TextInputType.text,
              controller: _tagFieldController,
              style: GoogleFonts.openSans(),
              decoration: InputDecoration(
                hintText: '',
                hintStyle: GoogleFonts.openSans(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide(
                    width: 0, 
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel', style: GoogleFonts.openSans(color: Colors.red)),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop('${_tagFieldController.text}'),
            child: Text('add', style: GoogleFonts.openSans(color: Colors.green)),
          ),
          SizedBox(width: 8.0),
        ],
      ),
    )) ?? '';
  }
}

class TagBadge extends StatelessWidget {
  final int _index;
  final String _value;

  TagBadge({@required index, @required value})
      : _index = index,
        _value = value;

  void _deleteTagDialog(context) async {
    bool result = (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove this tag ?', style: GoogleFonts.openSans()),
        content: Text('$_value', style: GoogleFonts.openSans()),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No', style: GoogleFonts.openSans()),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes', style: GoogleFonts.openSans()),
          ),
        ],
      ),
    )) ?? false;
    if (result) {
      BlocProvider.of<CreateCaseBloc>(context).add(TagRemoved(index: _index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.0),
      child: Badge(
        badgeColor: Color.fromRGBO(166, 200, 200, 1.0),
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        shape: BadgeShape.square,
        borderRadius: 20,
        toAnimate: false,
        badgeContent: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$_value', style: GoogleFonts.openSans(color: Colors.black)),
            SizedBox(width: 6.0,),
            GestureDetector(
              onTap: () {
                _deleteTagDialog(context);
              },
              child: Icon(FontAwesomeIcons.times, color: Colors.redAccent, size: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
