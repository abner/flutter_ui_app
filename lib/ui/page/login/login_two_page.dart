import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/api/common_api.dart';

class LoginTwoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginTwoPage();
  }
}

class _LoginTwoPage extends State<LoginTwoPage> {
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _userPasswordController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loginBody(),
      ),
    );
  }

  loginBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.green,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome to ${UIData.appName}",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _userNameController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                controller: _userPasswordController,
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: () {
                  var name = _userNameController.text.toString();
                  var password = _userPasswordController.text.toString();
                  _dioNet(name, password, context);
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "SIGN UP FOR AN ACCOUNT",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
}

void _dioNet(username, password, context) async {
  api.login(username, password).then((loginret) {
    if (loginret['code'] == 200) {
      showMyDialog(context,1);
    }else{
      showMyDialog(context,0);
    }
  });
}

void showMyDialog(BuildContext context,st) {
  bool showing = true;
  showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          '登录成功',
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop(true);
              showing = false;
            },
          ),
        ],
      );

//      return new SimpleDialog(
//        title: new Text('Test'),
//        children: <Widget>[
//          new RadioListTile(
//            title: new Text('Testing'), value: null, groupValue: null, onChanged: (value) {},
//          )
//        ],
//      );
      // return
    },
  );
}
