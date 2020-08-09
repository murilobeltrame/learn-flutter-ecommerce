import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    void _onSuccess(){
      Navigator.of(context).pop();
    }
    void _onFailure(){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Falha ao entrar.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
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
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
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
                  controller: _passwordController,
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
                        model.SignIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFailure: _onFailure);
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
          );
        },
      ),
    );
  }
}
