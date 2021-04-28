import 'package:coffiebro/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffiebro/services/auth.dart';
import 'package:coffiebro/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state

  String email = '';

  String passWord = '';

  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to coffier'),
        actions: <Widget> [
          TextButton.icon(onPressed:() {
            widget.toggleView();
          },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              SizedBox(height: 30.0),
              TextFormField(
               decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Enter a pass 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => passWord = val);
                  }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(

                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email,passWord);
                      if (result == null){
                        setState(() { error = 'please supply a valid email';
                        loading =false;
                        });
                      }
                    }
                  },

                  child:Text(
                    'Register',
                    style:

                    TextStyle(color: Colors.white),
                  )
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
              )
            ],
          ),
        ),
      ),
    );
  }
}
