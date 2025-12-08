import 'package:flutter/material.dart';
import '../models/local.dart';
import '../models/avaliacao_model.dart';
import '../models/favorito_model.dart';
import '../services/database_service.dart';

class LocalController extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  
  List<Local> _locais = [];
  List<Local> get locais => _locais;
  
  List<Avaliacao> _avaliacoes = [];
  List<Avaliacao> get avaliacoes => _avaliacoes;
  
  List<Favorito> _favoritos = [];
  List<Favorito> get favoritos => _favoritos;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  // Carregar todos os locais
  Future<void> carregarLocais() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // TODO: Implementar carregamento de locais do DatabaseService
      // Por enquanto, vamos criar alguns locais de exemplo
      _locais = await _databaseService.getLocais();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao carregar locais: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Buscar local por ID
  Local? getLocalById(String id) {
    return _locais.firstWhere((local) => local.id == id);
  }
  
  // Obter avaliações de um local
  List<Avaliacao> getAvaliacoesPorLocal(String localId) {
    return _avaliacoes
        .where((avaliacao) => avaliacao.localId == localId)
        .toList();
  }
  
  // Adicionar nova avaliação
  Future<bool> adicionarAvaliacao({
    required String localId,
    required String usuarioId,
    required String usuarioNome,
    String? usuarioFotoUrl,
    required double nota,
    required String comentario,
    String? dica,
    List<String>? fotosUrls,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final novaAvaliacao = Avaliacao(
        id: 'avaliacao_${DateTime.now().millisecondsSinceEpoch}',
        localId: localId,
        usuarioId: usuarioId,
        usuarioNome: usuarioNome,
        usuarioFotoUrl: usuarioFotoUrl,
        nota: nota,
        comentario: comentario,
        dica: dica,
        data: DateTime.now(),
        fotosUrls: fotosUrls ?? [],
      );
      

      _avaliacoes.add(novaAvaliacao);
      
      // Atualizar nota média do local
      await _atualizarNotaLocal(localId);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao adicionar avaliação: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
 
Future<void> curtirAvaliacao(String avaliacaoId, String usuarioId) async {
  final avaliacaoIndex = _avaliacoes.indexWhere((a) => a.id == avaliacaoId);
  
  if (avaliacaoIndex != -1) {
    final avaliacao = _avaliacoes[avaliacaoIndex];
    

    avaliacao.toggleCurtida(usuarioId);
    
    await _databaseService.curtirAvaliacao(avaliacaoId, usuarioId);
    
    notifyListeners();
  }
}

//  verificar se o usuário já curtiu
bool usuarioCurtiuAvaliacao(String avaliacaoId, String usuarioId) {
  final avaliacao = _avaliacoes.firstWhere(
    (a) => a.id == avaliacaoId,
    orElse: () => throw Exception("Avaliação não encontrada"),
  );
  
  return avaliacao.usuarioCurtiu(usuarioId);
}
  
  // Adicionar/remover favorito
  Future<bool> toggleFavorito(String localId, String usuarioId) async {
    try {
      final favoritoIndex = _favoritos.indexWhere(
        (f) => f.localId == localId && f.usuarioId == usuarioId,
      );
      
      if (favoritoIndex != -1) {
        // Remover dos favoritos
        _favoritos.removeAt(favoritoIndex);
        // TODO: Remover do DatabaseService
      } else {
        // Adicionar aos favoritos
        final novoFavorito = Favorito(
          id: 'favorito_${DateTime.now().millisecondsSinceEpoch}',
          usuarioId: usuarioId,
          localId: localId,
          dataAdicao: DateTime.now(),
        );
        _favoritos.add(novoFavorito);
        // TODO: Salvar no DatabaseService
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao atualizar favoritos: $e';
      return false;
    }
  }
  
  // Verificar se local é favorito do usuário
  bool isFavorito(String localId, String usuarioId) {
    return _favoritos.any(
      (f) => f.localId == localId && f.usuarioId == usuarioId,
    );
  }
  
  // Obter favoritos do usuário
  List<Local> getFavoritosDoUsuario(String usuarioId) {
    final favoritosIds = _favoritos
        .where((f) => f.usuarioId == usuarioId)
        .map((f) => f.localId)
        .toList();
    
    return _locais.where((local) => favoritosIds.contains(local.id)).toList();
  }
  
  // Filtrar locais por categoria
  List<Local> filtrarPorCategoria(String categoria) {
    return _locais.where((local) => local.categoria == categoria).toList();
  }
  
  // Filtrar locais por tags
  List<Local> filtrarPorTags(List<String> tags) {
    return _locais.where((local) {
      return tags.every((tag) => local.tags.contains(tag));
    }).toList();
  }
  
  // Buscar locais por nome
  List<Local> buscarLocais(String query) {
    if (query.isEmpty) return _locais;
    
    return _locais.where((local) {
      return local.nome.toLowerCase().contains(query.toLowerCase()) ||
             local.descricao.toLowerCase().contains(query.toLowerCase()) ||
             local.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }
  
  // Atualizar nota média do local
  Future<void> _atualizarNotaLocal(String localId) async {
    final avaliacoesLocal = getAvaliacoesPorLocal(localId);
    
    if (avaliacoesLocal.isNotEmpty) {
      final double novaNotaMedia = avaliacoesLocal
          .map((a) => a.nota)
          .reduce((a, b) => a + b) /
          avaliacoesLocal.length;
      
      final localIndex = _locais.indexWhere((l) => l.id == localId);
      if (localIndex != -1) {
        final local = _locais[localIndex];
        // TODO: Atualizar no DatabaseService
        // Por enquanto, apenas atualizamos na memória
        _locais[localIndex] = Local(
          id: local.id,
          nome: local.nome,
          descricao: local.descricao,
          latitude: local.latitude,
          longitude: local.longitude,
          imagem: local.imagem,
          categoria: local.categoria,
          endereco: local.endereco,
          telefone: local.telefone,
          horarioFuncionamento: local.horarioFuncionamento,
          precoMedio: local.precoMedio,
          tags: local.tags,
          notaMedia: novaNotaMedia,
          totalAvaliacoes: avaliacoesLocal.length,
        );
        
        notifyListeners();
      }
    }
  }
}