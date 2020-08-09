import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _addressController = TextEditingController();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    void _onSuccess(){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Usuário criado com sucesso.'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 3),
      ));
      Future.delayed(Duration(seconds: 3)).then((_) => Navigator.of(context).pop());
    }
    void _onFailure(){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Falha ao criar o usuário.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
      Future.delayed(Duration(seconds: 3)).then((_) => Navigator.of(context).pop());
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator(),);
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  validator: (text) {
                    if (text.isEmpty) return 'Nome inválido';
                  },
                  decoration: InputDecoration(
                      hintText: 'Nome'
                  ),
                  controller: _nameController,
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@')) return 'E-mail inválido';
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'E-mail'
                  ),
                  controller: _emailController,
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
                  controller: _passwordController,
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  validator: (text) {
                    if (text.isEmpty) return 'Endereço inválida';
                  },
                  decoration: InputDecoration(
                    hintText: 'Endereço',
                  ),
                  controller: _addressController,
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState.validate()) {

                        Map<String, dynamic> userData = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'address': _addressController.text
                        };

                        model.SignUp(
                          userData: userData,
                          password: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFailure: _onFailure);
                      }
                    },
                    child: Text(
                      'Criar Conta',
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
