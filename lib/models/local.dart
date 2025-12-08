class Local {
  final String id; // Adicionar ID único
  final String nome;
  final String descricao;
  final double latitude;
  final double longitude;
  final String? imagem;
  final String categoria; // 'ponto_turistico', 'restaurante', 'hotel', etc.
  final String? endereco;
  final String? telefone;
  final String? horarioFuncionamento;
  final double? precoMedio; // Para restaurantes
  final List<String> tags; // Ex: ['ar-livre', 'familiar', 'romântico']
  final double notaMedia; // 0-5
  final int totalAvaliacoes;

  Local({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.latitude,
    required this.longitude,
    this.imagem,
    required this.categoria,
    this.endereco,
    this.telefone,
    this.horarioFuncionamento,
    this.precoMedio,
    this.tags = const [],
    this.notaMedia = 0.0,
    this.totalAvaliacoes = 0,
  });
}