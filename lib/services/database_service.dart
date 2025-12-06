import '../models/user_model.dart';

class DatabaseService {
  // Simulação do nosso banco de dadosem memoria
  final List<UserModel> _users = []; 
  int _nextId = 1;

  Future<UserModel?> registerUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500)); 
    if (_users.any((u) => u.email == user.email)) {
      print('Erro: O e-mail ${user.email} já está cadastrado.');
      return null;
    }
    final newUser = UserModel(
      id: _nextId++,
      name: user.name,
      email: user.email,
      password: user.password,
    );
    _users.add(newUser);
    print('Usuário cadastrado com sucesso: $newUser');
    return newUser;
  }
  Future<UserModel?> authenticateUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500)); 
    
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      
      print('Autenticação bem-sucedida para o usuário: ${user.name}');
      return user;
    } catch (e) {
      print('Erro de autenticação: Credenciais inválidas para $email');
      return null;
    }
  }
  Future<List<UserModel>> getAllUsers() async {
    return _users;
  }
}