import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Criar Conta',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignupScreen())
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              validator: (text) {
                if (text.isEmpty || !text.contains('@')) return 'E-mail inválido';
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-mail'
              ),
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              validator: (text) {
                if (text.isEmpty || text.length < 6) return 'Senha inválida';
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Senha',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: (){},
                padding: EdgeInsets.zero,
                child: Text(
                  'Esqueci minha senha',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(height: 16.0,),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    
                  }
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
