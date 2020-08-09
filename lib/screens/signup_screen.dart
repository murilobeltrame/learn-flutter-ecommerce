import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
      ),
      body: Form(
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
            SizedBox(height: 16.0,),
            TextFormField(
              validator: (text) {
                if (text.isEmpty) return 'Endereço inválida';
              },
              decoration: InputDecoration(
                hintText: 'Endereço',
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
      ),
    );

  }
}
