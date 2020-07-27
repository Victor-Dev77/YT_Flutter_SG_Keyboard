import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const N = 10;
  static const PASSWORD_LENGHT = 6;

  static var _numbers = Iterable<int>.generate(N).toList()
    ..shuffle(); // shuffle retourne void donc .. si inline
  String _password = "";
  int _passwordLenght = 0;

  bool get isValid => _passwordLenght == PASSWORD_LENGHT;
  bool get showBtnDelete => _passwordLenght > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildResultPassword(),
            _buildKeyBoard(isValid),
            _buildBtnValid(isValid),
          ],
        ),
      ),
    );
  }

  Widget _buildResultPassword() {
    return Column(
      children: <Widget>[
        Text(
          "Saissisez votre code secret",
          style: TextStyle(fontSize: 18),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 20),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(PASSWORD_LENGHT, (index) {
              return Container(
                width: 15,
                height: 15,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (index < _passwordLenght)
                        ? Colors.grey
                        : Colors.grey[350]),
              );
            }),
          ),

          _buildIconDelete(showBtnDelete),
      
            ],
          )
        )
      ],
    );
  }

  Widget _buildIconDelete(bool show) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () => _reInitPassword(),
        child: show ? Icon(Icons.close) : Icon(null),
      ),
    );
  }

  Widget _buildKeyBoard(bool isValidPassword) {
    List<Widget> _touchKeyboard = List.generate(N, (index) {
      return InkWell(
        onTap: !isValidPassword ? () => _addNumber(_numbers[index]) : null,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.grey[400])),
          child: Center(
            child: Text(
              _numbers[index].toString(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
          ),
        ),
      );
    });

    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width - 100,
      //color: Colors.red,
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(0),
        children: _touchKeyboard,
      ),
    );
  }

  Widget _buildBtnValid(bool isValidBtn) {
    return GestureDetector(
        onTap: isValidBtn ? () => print("this is the password: $_password") : null,
        child: Opacity(
          opacity: isValidBtn ? 1.0 : 0.5,
          child: Container(
            height: 75,
            width: MediaQuery.of(context).size.width * .6,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(64),
            ),
            child: Center(
              child: Text(
                "Valider",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ));
  }

  _addNumber(int number) {
    setState(() {
      _password += "$number"; // <==> number.toString()
      _passwordLenght++;
    });
  }

  _reInitPassword() {
    setState(() {
      _password = "";
      _passwordLenght = 0;
    });
  }
}
