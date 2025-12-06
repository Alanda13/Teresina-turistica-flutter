import 'package:flutter/material.dart';
import 'RegistrationView.dart';
import '../controllers/global_controller.dart'; 
import 'HomeView.dart'; 

final _userController = userController;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}
class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  
  void _efetuarLogin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final senha = _senhaController.text;
      final success = await _userController.login(email, senha);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login efetuado! Bem-vindo(a), ${_userController.currentUser!.name.split(' ').first}.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeView()),
          (Route<dynamic> route) => false, 
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_userController.errorMessage ?? 'Erro de login. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navegarParaCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationView()),
    );
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Colors.tealAccent : Colors.green[700];
    final accentColor = Colors.amber; 

    return ListenableBuilder(
      listenable: _userController,
      builder: (context, child) {
        final bool isLoading = _userController.isLoading;

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Column(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 100,
                          color: primaryColor, 
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Teresina Turística',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: primaryColor, 
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Seu guia interativo em Teresina',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),
                    TextFormField(
                      controller: _emailController,
                      enabled: !isLoading, 
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'seu.email@exemplo.com',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Insira um e-mail válido.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _senhaController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Mínimo 6 caracteres',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility), 
                          onPressed: isLoading ? null : () {},
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Mínimo 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: isLoading ? null : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Em breve: Recuperar Senha')),
                          );
                        },
                        child: Text(
                          'Esqueci a senha',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: isLoading ? null : _efetuarLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.black, 
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.black) 
                          : const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem uma conta?'),
                        TextButton(
                          onPressed: isLoading ? null : _navegarParaCadastro,
                          child: Text(
                            'Cadastrar agora',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}