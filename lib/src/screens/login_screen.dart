import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  // Declaring bloc instance
  // This is stateless widget so this is immutable and dart except all variables to be final
  // inside stateless widget.
  Bloc _bloc;

  @override
  Widget build(BuildContext context) {
    // Initializing bloc instance by calling of() method which is defined in Provider class.
    _bloc = Provider.of(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      // Single global instance way
      stream: _bloc.email,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          // onChanged: (String email) {
          //   bloc.changeEmail(email);
          // },
          // Above onChanged and below onChanged function are same.
          // Single global instance way
          onChanged: _bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'email@example.com',
            labelText: 'EMail Address',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      // Single global instance way
      stream: _bloc.password,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          // Single global instance way
          onChanged: _bloc.changePassword,
          // Replace password character by symbol
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: _bloc.submit,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
          child: Text("Login"),
          color: Colors.blue,
          onPressed: snapshot.hasError
              ? null
              : () {
                  print("Hi there");
                },
        );
      },
    );
  }
}
