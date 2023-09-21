import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String nome;
  final String email;
  final String tipoDeAcesso;

  User({required this.nome, required this.email, required this.tipoDeAcesso});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        primaryColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _tipoAcessoController = TextEditingController();

  void _navigateToUserInfo(User user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => UserInfoPage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(37.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome Completo',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email de Acesso',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tipoAcessoController,
                  decoration: InputDecoration(
                    labelText: 'Tipo Acesso',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o tipo de acesso';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = User(
                        nome: _nomeController.text,
                        email: _emailController.text,
                        tipoDeAcesso: _tipoAcessoController.text,
                      );
                      _navigateToUserInfo(user);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  final User user;

  UserInfoPage({required this.user});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool _showInfo = true;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Ocultar Informações', style: TextStyle(fontSize: 20)),
        content: Text('Você deseja ocultar as informações?', style: TextStyle(fontSize: 18)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar', style: TextStyle(fontSize: 18)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _showInfo = false;
              });
              Navigator.of(context).pop();
            },
            child: Text('Confirmar', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.nome, style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_showInfo) ...[
                Text(
                  'Nome: ${widget.user.nome}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Email: ${widget.user.email}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Tipo de Acesso: ${widget.user.tipoDeAcesso}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
              ElevatedButton(
                onPressed: () {
                  if (_showInfo) {
                    _showConfirmationDialog();
                  } else {
                    setState(() {
                      _showInfo = true;
                    });
                  }
                },
                child: Text(
                  _showInfo ? 'Ocultar Informações' : 'Exibir Informações',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


