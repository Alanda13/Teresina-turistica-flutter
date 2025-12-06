class Local {
  final String nome;
  final String descricao;
  final double latitude;
  final double longitude;
  final String? imagem; 

  Local({
    required this.nome,
    required this.descricao,
    required this.latitude,
    required this.longitude,
    this.imagem,
  });
}
