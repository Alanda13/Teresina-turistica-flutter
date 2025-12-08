class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? fotoPerfilUrl;
  final List<String> preferencias; // Ex: ['ar-livre', 'restaurante']
  final DateTime dataCadastro;
  
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.fotoPerfilUrl,
    this.preferencias = const [],
    required this.dataCadastro,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      fotoPerfilUrl: map['fotoPerfilUrl'] as String?,
      preferencias: List<String>.from(map['preferencias'] ?? []),
      dataCadastro: DateTime.parse(map['dataCadastro'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'fotoPerfilUrl': fotoPerfilUrl,
      'preferencias': preferencias,
      'dataCadastro': dataCadastro.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, preferencias: $preferencias)';
  }
}