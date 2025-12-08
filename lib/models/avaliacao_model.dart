import 'dart:convert';

class Avaliacao {
  final String id;
  final String localId;
  final String usuarioId;
  final String usuarioNome;
  final String? usuarioFotoUrl;
  final double nota; // 1-5
  final String comentario;
  final String? dica; // Sugestão do que fazer/experimentar
  final DateTime data;
  int curtidas; // Remover "final" para poder modificar
  final List<String> usuariosQueCurtiram; // IDs dos usuários que curtiram
  final List<String> fotosUrls; // Fotos anexadas pelo usuário

  Avaliacao({
    required this.id,
    required this.localId,
    required this.usuarioId,
    required this.usuarioNome,
    this.usuarioFotoUrl,
    required this.nota,
    required this.comentario,
    this.dica,
    required this.data,
    this.curtidas = 0, // ✅ Agora pode ser modificado
    this.usuariosQueCurtiram = const [],
    this.fotosUrls = const [],
  });

  factory Avaliacao.fromMap(Map<String, dynamic> map) {
    return Avaliacao(
      id: map['id'] as String,
      localId: map['localId'] as String,
      usuarioId: map['usuarioId'] as String,
      usuarioNome: map['usuarioNome'] as String,
      usuarioFotoUrl: map['usuarioFotoUrl'] as String?,
      nota: (map['nota'] as num).toDouble(),
      comentario: map['comentario'] as String,
      dica: map['dica'] as String?,
      data: DateTime.parse(map['data'] as String),
      curtidas: (map['curtidas'] as int?) ?? 0,
      usuariosQueCurtiram: List<String>.from(map['usuariosQueCurtiram'] ?? []),
      fotosUrls: List<String>.from(map['fotosUrls'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'localId': localId,
      'usuarioId': usuarioId,
      'usuarioNome': usuarioNome,
      'usuarioFotoUrl': usuarioFotoUrl,
      'nota': nota,
      'comentario': comentario,
      'dica': dica,
      'data': data.toIso8601String(),
      'curtidas': curtidas,
      'usuariosQueCurtiram': usuariosQueCurtiram,
      'fotosUrls': fotosUrls,
    };
  }

  String toJson() => json.encode(toMap());
  factory Avaliacao.fromJson(String source) => Avaliacao.fromMap(json.decode(source));

  // Método para curtir/descurtir
  void toggleCurtida(String usuarioId) {
    if (usuariosQueCurtiram.contains(usuarioId)) {
      // Descurtir
      usuariosQueCurtiram.remove(usuarioId);
      curtidas--;
    } else {
      // Curtir
      usuariosQueCurtiram.add(usuarioId);
      curtidas++;
    }
  }

  // Verificar se um usuário curtiu esta avaliação
  bool usuarioCurtiu(String usuarioId) {
    return usuariosQueCurtiram.contains(usuarioId);
  }
}