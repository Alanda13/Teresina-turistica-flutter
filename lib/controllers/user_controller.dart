import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';

class UserController extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService(); 
  
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); 
    
    try {
      final newUser = UserModel(
        name: name, 
        email: email, 
        password: password,
        dataCadastro: DateTime.now(),
      );
      
      final registeredUser = await _databaseService.registerUser(newUser);
      
      if (registeredUser != null) {
        _currentUser = registeredUser;
        _isLoading = false;
        notifyListeners(); 
        return true;
      } else {
        _errorMessage = 'E-mail já cadastrado.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Erro ao cadastrar. Tente novamente.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    // Usuário de teste (remover depois)
    if (email == "alanda@gmail.com" && password == "123456") {
      _currentUser = UserModel(
        id: 1,
        name: "Alanda",
        email: "alanda@gmail.com",
        password: "",
        dataCadastro: DateTime.now(),
        preferencias: ['ar-livre', 'restaurante'],
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }
    
    try {
      final user = await _databaseService.authenticateUser(email, password);
      
      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Credenciais inválidas.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Erro de autenticação.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void logout() {
    _currentUser = null;
    notifyListeners(); 
  }
  
  bool isAuthenticated() {
    return _currentUser != null;
  }
  
  // Atualizar preferências do usuário
  Future<void> atualizarPreferencias(List<String> novasPreferencias) async {
    if (_currentUser != null) {
      // TODO: Implementar atualização no banco de dados
      _currentUser = UserModel(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: _currentUser!.email,
        password: _currentUser!.password,
        fotoPerfilUrl: _currentUser!.fotoPerfilUrl,
        preferencias: novasPreferencias,
        dataCadastro: _currentUser!.dataCadastro,
      );
      notifyListeners();
    }
  }
}