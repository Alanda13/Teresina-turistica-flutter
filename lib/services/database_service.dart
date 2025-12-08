import '../models/local.dart';
import '../models/avaliacao_model.dart';
import '../models/favorito_model.dart';
import '../models/user_model.dart';



class DatabaseService {
  // Dados em memória (simulação)
  final List<UserModel> _users = [];
  final List<Local> _locais = [];
  final List<Avaliacao> _avaliacoes = [];
  final List<Favorito> _favoritos = [];
  
  int _nextUserId = 1;
  int _nextAvaliacaoId = 1000;
  int _nextFavoritoId = 1000;
  
  DatabaseService() {
    // Inicializar com dados de exemplo
    _initializeSampleData();
    _printStatus(); // Mostrar status inicial
    debugDatabase();
  }

  void debugDatabase() {
  print('\n=== DEBUG DATABASE ===');
  print('Total de avaliações: ${_avaliacoes.length}');
  
  // Listar todas as avaliações com seus IDs de local
  for (var avaliacao in _avaliacoes) {
    print('• ${avaliacao.id} → Local: ${avaliacao.localId} | Usuário: ${avaliacao.usuarioNome}');
  }
  
  // Listar todos os locais com seus IDs
  print('\nLocais disponíveis:');
  for (var local in _locais) {
    print('• ${local.id} → ${local.nome}');
  }
  
  // Verificar avaliações por local específico
  print('\nAvaliações por local:');
  for (var local in _locais.take(3)) { // Verifica só os 3 primeiros
    final avaliacoesLocal = _avaliacoes.where((a) => a.localId == local.id).toList();
    print('• ${local.nome} (${local.id}): ${avaliacoesLocal.length} avaliações');
  }
  print('=====================\n');
}
  
  void _initializeSampleData() {
    // ========== LOCAIS DE TERESINA ==========
    _locais.addAll([
      // PONTOS TURÍSTICOS
      Local(
        id: 'ponte_estaiada_1',
        nome: 'Ponte Estaiada',
        descricao: 'Ponto turístico com mirante oferecendo vista panorâmica da cidade',
        latitude: -5.0808,
        longitude: -42.8048,
        imagem: 'assets/images/ponte_estaiada.jpg',
        categoria: 'ponto_turistico',
        endereco: 'Av. Raul Lopes, 1000 - Buenos Aires, Teresina - PI',
        horarioFuncionamento: '24 horas',
        notaMedia: 4.7,
        totalAvaliacoes: 125,
        tags: ['mirante', 'ar-livre', 'fotografia', 'noite'],
      ),
      Local(
        id: 'encontro_rios_1',
        nome: 'Encontro dos Rios',
        descricao: 'Onde o Rio Poti encontra o Rio Parnaíba, cenário deslumbrante',
        latitude: -5.0871,
        longitude: -42.8089,
        imagem: 'assets/images/encontro_dos_rios.jpg',
        categoria: 'ponto_turistico',
        endereco: 'Margem do Rio Poti, Teresina - PI',
        horarioFuncionamento: '06:00-18:00',
        notaMedia: 4.5,
        totalAvaliacoes: 89,
        tags: ['natureza', 'rio', 'pôr-do-sol', 'tranquilidade'],
      ),
      Local(
        id: 'parque_potycabana_1',
        nome: 'Parque Potycabana',
        descricao: 'Área de lazer ao ar livre com quadras esportivas e ciclovia',
        latitude: -5.0902,
        longitude: -42.8019,
        imagem: 'assets/images/parque_potycabana.jpg',
        categoria: 'ponto_turistico',
        endereco: 'Av. Maranhão - Centro, Teresina - PI',
        horarioFuncionamento: '05:00-22:00',
        notaMedia: 4.3,
        totalAvaliacoes: 67,
        tags: ['parque', 'ar-livre', 'exercícios', 'família'],
      ),
      Local(
        id: 'museu_piaui_1',
        nome: 'Museu do Piauí',
        descricao: 'Museu histórico que preserva a cultura e história do estado',
        latitude: -5.0909,
        longitude: -42.8014,
        imagem: 'assets/images/museu_piaui.jpg',
        categoria: 'ponto_turistico',
        endereco: 'R. Coelho Rodrigues, 193 - Centro, Teresina - PI',
        telefone: '(86) 3221-6027',
        horarioFuncionamento: '09:00-17:00 (fechado segundas)',
        notaMedia: 4.8,
        totalAvaliacoes: 42,
        tags: ['museu', 'história', 'cultura', 'educativo'],
      ),
      Local(
        id: 'igreja_sao_benedito_1',
        nome: 'Igreja São Benedito',
        descricao: 'Uma das mais antigas e belas igrejas da cidade',
        latitude: -5.0913,
        longitude: -42.8052,
        imagem: 'assets/images/sao_benedito.jpg',
        categoria: 'ponto_turistico',
        endereco: 'Praça Saraiva - Centro, Teresina - PI',
        horarioFuncionamento: '07:00-18:00',
        notaMedia: 4.6,
        totalAvaliacoes: 56,
        tags: ['histórico', 'religioso', 'arquitetura', 'paz'],
      ),
      Local(
        id: 'teatro_4_setembro_1',
        nome: 'Teatro 4 de Setembro',
        descricao: 'Centro cultural e artístico tradicional de Teresina',
        latitude: -5.0904,
        longitude: -42.8035,
        imagem: 'assets/images/teatro_4_setembro.jpg',
        categoria: 'ponto_turistico',
        endereco: 'R. Alvaro Mendes, 195 - Centro, Teresina - PI',
        telefone: '(86) 3216-3100',
        horarioFuncionamento: '09:00-17:00',
        notaMedia: 4.5,
        totalAvaliacoes: 78,
        tags: ['teatro', 'cultura', 'arte', 'espetáculos'],
      ),
      Local(
        id: 'praca_pedro_ii_1',
        nome: 'Praça Pedro II',
        descricao: 'Praça histórica no coração do centro de Teresina',
        latitude: -5.0905,
        longitude: -42.8037,
        imagem: 'assets/images/praca_pedro_segundo.jpg',
        categoria: 'ponto_turistico',
        endereco: 'Centro, Teresina - PI',
        horarioFuncionamento: '24 horas',
        notaMedia: 4.2,
        totalAvaliacoes: 91,
        tags: ['praça', 'histórico', 'centro', 'descanso'],
      ),
      
      // SHOPPINGS
      Local(
        id: 'shopping_rio_poty_1',
        nome: 'Shopping Rio Poty',
        descricao: 'Principal shopping da cidade com diversas opções de lazer',
        latitude: -5.0879,
        longitude: -42.8037,
        imagem: 'assets/images/shopping_rio_poty.jpg',
        categoria: 'shopping',
        endereco: 'Av. Raul Lopes, 1000 - Buenos Aires, Teresina - PI',
        telefone: '(86) 3215-1515',
        horarioFuncionamento: '10:00-22:00 (seg a sáb), 14:00-20:00 (dom)',
        precoMedio: null,
        notaMedia: 4.4,
        totalAvaliacoes: 234,
        tags: ['compras', 'cinema', 'alimentação', 'lazer'],
      ),
      Local(
        id: 'shopping_teresina_1',
        nome: 'Shopping Teresina',
        descricao: 'Shopping com variedade de lojas e praça de alimentação',
        latitude: -5.0835,
        longitude: -42.7950,
        imagem: 'assets/images/shopping_teresina.jpg',
        categoria: 'shopping',
        endereco: 'Av. Frei Serafim, 2000 - Centro, Teresina - PI',
        telefone: '(86) 3222-6000',
        horarioFuncionamento: '10:00-22:00',
        precoMedio: null,
        notaMedia: 4.3,
        totalAvaliacoes: 189,
        tags: ['compras', 'variedade', 'acessível', 'família'],
      ),
      
      // RESTAURANTES
      Local(
        id: 'coco_bambu_teresina_1',
        nome: 'Coco Bambu Teresina',
        descricao: 'Famoso por frutos do mar de alta qualidade e ambiente sofisticado',
        latitude: -5.0856,
        longitude: -42.7976,
        imagem: 'assets/images/coco_bambu.jpg',
        categoria: 'restaurante',
        endereco: 'Av. João XXIII, 2555 - Jóquei, Teresina - PI',
        telefone: '(86) 3215-5555',
        horarioFuncionamento: '12:00-23:00',
        precoMedio: 120.0,
        notaMedia: 4.8,
        totalAvaliacoes: 342,
        tags: ['frutos-do-mar', 'sofisticado', 'alto-padrão', 'romântico'],
      ),
      /*Local(
        id: 'tia_rosa_1',
        nome: 'Tia Rosa Panelas & Temperos',
        descricao: 'Comida típica piauiense caseira em ambiente acolhedor',
        latitude: -5.0889,
        longitude: -42.8001,
        imagem: 'assets/images/tia_rosa.jpg',
        categoria: 'restaurante',
        endereco: 'R. Coelho Rodrigues, 123 - Centro, Teresina - PI',
        telefone: '(86) 3222-3344',
        horarioFuncionamento: '11:00-22:00',
        precoMedio: 45.0,
        notaMedia: 4.6,
        totalAvaliacoes: 156,
        tags: ['comida-típica', 'acolhedor', 'barato', 'caseiro'],
      ),
      Local(
        id: 'cantinho_do_boi_1',
        nome: 'Cantinho do Boi',
        descricao: 'Melhor churrascaria da cidade com carnes selecionadas',
        latitude: -5.0832,
        longitude: -42.7995,
        imagem: 'assets/images/cantinho_do_boi.jpg',
        categoria: 'restaurante',
        endereco: 'Rua Governador Rocha Furtado, 477 - Centro, Teresina - PI',
        telefone: '(86) 3221-6565',
        horarioFuncionamento: '11:30-23:00',
        precoMedio: 75.0,
        notaMedia: 4.7,
        totalAvaliacoes: 289,
        tags: ['churrascaria', 'carnes', 'rodízio', 'tradicional'],
      ),
      Local(
        id: 'restaurante_do_porto_1',
        nome: 'Restaurante do Porto',
        descricao: 'Especializado em peixes e pratos regionais à beira do rio',
        latitude: -5.0865,
        longitude: -42.8062,
        imagem: 'assets/images/restaurante_porto.jpg',
        categoria: 'restaurante',
        endereco: 'Av. Maranhão, 1234 - Centro, Teresina - PI',
        telefone: '(86) 3223-4455',
        horarioFuncionamento: '11:00-23:00',
        precoMedio: 60.0,
        notaMedia: 4.4,
        totalAvaliacoes: 134,
        tags: ['peixes', 'regional', 'vista-rio', 'família'],
      ),
      Local(
        id: 'pizza_hut_teresina_1',
        nome: 'Pizza Hut Teresina',
        descricao: 'Famosa rede de pizzas com ambiente familiar',
        latitude: -5.0845,
        longitude: -42.7988,
        imagem: 'assets/images/pizza_hut.jpg',
        categoria: 'restaurante',
        endereco: 'Av. Frei Serafim, 1850 - Centro, Teresina - PI',
        telefone: '(86) 3221-7788',
        horarioFuncionamento: '18:00-23:00',
        precoMedio: 55.0,
        notaMedia: 4.2,
        totalAvaliacoes: 98,
        tags: ['pizza', 'fast-food', 'família', 'entrega'],
      ),*/
    ]);

    // ========== AVALIAÇÕES DE EXEMPLO ==========
    _avaliacoes.addAll([
      // Avaliações para Ponte Estaiada
      Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'ponte_estaiada_1',
        usuarioId: '1',
        usuarioNome: 'Maria Silva',
        usuarioFotoUrl: null,
        nota: 5.0,
        comentario: 'Vista incrível ao pôr do sol! Imperdível para quem visita Teresina.',
        dica: 'Visite no final da tarde e leve uma câmera para fotos espetaculares',
        data: DateTime.now().subtract(Duration(days: 5)),
        curtidas: 12,
        usuariosQueCurtiram: ['2', '3', '4', '5'],
        fotosUrls: [],
      ),
      Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'ponte_estaiada_1',
        usuarioId: '2',
        usuarioNome: 'Carlos Oliveira',
        usuarioFotoUrl: null,
        nota: 4.0,
        comentario: 'Linda estrutura, mas poderia ter mais segurança à noite.',
        dica: 'Evite ir muito tarde sozinho',
        data: DateTime.now().subtract(Duration(days: 3)),
        curtidas: 8,
        usuariosQueCurtiram: ['1', '3'],
        fotosUrls: [],
      ),

      // Avaliações para Coco Bambu
      Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'coco_bambu_teresina_1',
        usuarioId: '3',
        usuarioNome: 'Ana Paula Santos',
        usuarioFotoUrl: null,
        nota: 5.0,
        comentario: 'Comida divina! O atendimento é impecável e o ambiente muito agradável.',
        dica: 'Experimente a moqueca de camarão e peça a caipirinha de maracujá',
        data: DateTime.now().subtract(Duration(days: 2)),
        curtidas: 15,
        usuariosQueCurtiram: ['1', '2', '4', '5', '6'],
        fotosUrls: [],
      ),
      Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'coco_bambu_teresina_1',
        usuarioId: '4',
        usuarioNome: 'Roberto Almeida',
        usuarioFotoUrl: null,
        nota: 4.5,
        comentario: 'Excelente qualidade, mas os preços são um pouco salgados.',
        dica: 'Vá no almoço executivo que é mais em conta',
        data: DateTime.now().subtract(Duration(days: 1)),
        curtidas: 7,
        usuariosQueCurtiram: ['1', '3'],
        fotosUrls: [],
      ),

      // Avaliações para Encontro dos Rios
      Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'encontro_rios_1',
        usuarioId: '5',
        usuarioNome: 'Fernanda Costa',
        usuarioFotoUrl: null,
        nota: 4.8,
        comentario: 'Lugar perfeito para ver o pôr do sol e relaxar.',
        dica: 'Leve repelente e vá no final da tarde',
        data: DateTime.now().subtract(Duration(days: 4)),
        curtidas: 10,
        usuariosQueCurtiram: ['1', '2', '3'],
        fotosUrls: [],
      ),

      // Avaliações para Tia Rosa
      Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'tia_rosa_1',
        usuarioId: '6',
        usuarioNome: 'José Pereira',
        usuarioFotoUrl: null,
        nota: 4.7,
        comentario: 'Comida caseira maravilhosa! Sabe como a vovó fazia.',
        dica: 'Peça o bode assado, é especialidade da casa',
        data: DateTime.now().subtract(Duration(days: 2)),
        curtidas: 9,
        usuariosQueCurtiram: ['1', '4', '5'],
        fotosUrls: [],
      ),

      // Avaliações para Cantinho do Boi
      /*Avaliacao(
        id: 'avaliacao_${_nextAvaliacaoId++}',
        localId: 'cantinho_do_boi_1',
        usuarioId: '7',
        usuarioNome: 'Pedro Henrique',
        usuarioFotoUrl: null,
        nota: 4.9,
        comentario: 'Melhor churrasco de Teresina! Carnes macias e saborosas.',
        dica: 'Experimente a picanha e a costela',
        data: DateTime.now().subtract(Duration(days: 1)),
        curtidas: 11,
        usuariosQueCurtiram: ['2', '3', '6'],
        fotosUrls: [],
      ),*/
    ]);

    // ========== USUÁRIO DE TESTE ==========
    // Adicionar usuário de teste "alanda@gmail.com"
    final testUser = UserModel(
      id: 999,
      name: 'Alanda',
      email: 'alanda@gmail.com',
      password: '123456',
      fotoPerfilUrl: null,
      preferencias: ['ar-livre', 'restaurante', 'ponto_turistico'],
      dataCadastro: DateTime.now().subtract(Duration(days: 30)),
    );
    _users.add(testUser);

    // ========== FAVORITOS DE TESTE ==========
    // Usuário teste favoritou alguns locais
    _favoritos.addAll([
      Favorito(
        id: 'favorito_${_nextFavoritoId++}',
        usuarioId: '999', // ID do usuário de teste
        localId: 'ponte_estaiada_1',
        dataAdicao: DateTime.now().subtract(Duration(days: 7)),
      ),
      Favorito(
        id: 'favorito_${_nextFavoritoId++}',
        usuarioId: '999',
        localId: 'coco_bambu_teresina_1',
        dataAdicao: DateTime.now().subtract(Duration(days: 5)),
      ),
      Favorito(
        id: 'favorito_${_nextFavoritoId++}',
        usuarioId: '999',
        localId: 'encontro_rios_1',
        dataAdicao: DateTime.now().subtract(Duration(days: 3)),
      ),
    ]);
  }

  void _printStatus() {
    print('''
╔══════════════════════════════════════╗
║     DATABASE SERVICE INICIALIZADO    ║
╠══════════════════════════════════════╣
║ • Usuários: ${_users.length.toString().padRight(4)} cadastrados      ║
║ • Locais: ${_locais.length.toString().padRight(5)} pontos turísticos ║
║ • Avaliações: ${_avaliacoes.length.toString().padRight(4)} registradas  ║
║ • Favoritos: ${_favoritos.length.toString().padRight(4)} salvos         ║
╚══════════════════════════════════════╝
    ''');
  }

  // ========== USUÁRIOS ==========
  Future<UserModel?> registerUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_users.any((u) => u.email == user.email)) {
      print('⚠️  E-mail ${user.email} já cadastrado.');
      return null;
    }
    
    final newUser = UserModel(
      id: _nextUserId++,
      name: user.name,
      email: user.email,
      password: user.password,
      fotoPerfilUrl: user.fotoPerfilUrl,
      preferencias: user.preferencias,
      dataCadastro: DateTime.now(),
    );
    
    _users.add(newUser);
    print('✅ Usuário cadastrado: ${newUser.name} (ID: ${newUser.id})');
    return newUser;
  }
  
  Future<UserModel?> authenticateUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      
      print('✅ Login bem-sucedido: ${user.name}');
      return user;
    } catch (e) {
      print('❌ Credenciais inválidas para: $email');
      return null;
    }
  }
  
  Future<List<UserModel>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_users);
  }
  
  Future<UserModel?> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  // ========== LOCAIS ==========
  Future<List<Local>> getLocais() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_locais);
  }
  
  Future<Local?> getLocalById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _locais.firstWhere((local) => local.id == id);
    } catch (e) {
      print('❌ Local não encontrado: $id');
      return null;
    }
  }
  
  Future<List<Local>> filtrarLocaisPorCategoria(String categoria) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _locais
        .where((local) => local.categoria == categoria)
        .toList();
  }
  
  Future<List<Local>> buscarLocais(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return getLocais();
    
    final queryLower = query.toLowerCase();
    return _locais.where((local) {
      return local.nome.toLowerCase().contains(queryLower) ||
             local.descricao.toLowerCase().contains(queryLower) ||
             local.tags.any((tag) => tag.toLowerCase().contains(queryLower));
    }).toList();
  }
  
  Future<List<Local>> getLocaisPorIds(List<String> ids) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _locais
        .where((local) => ids.contains(local.id))
        .toList();
  }

  // ========== AVALIAÇÕES ==========
  Future<List<Avaliacao>> getAvaliacoesPorLocal(String localId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _avaliacoes
        .where((avaliacao) => avaliacao.localId == localId)
        .toList();
  }
  
  Future<List<Avaliacao>> getAvaliacoesPorUsuario(String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _avaliacoes
        .where((avaliacao) => avaliacao.usuarioId == usuarioId)
        .toList();
  }
  
  Future<Avaliacao?> adicionarAvaliacao(Avaliacao avaliacao) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final novaAvaliacao = Avaliacao(
      id: 'avaliacao_${DateTime.now().millisecondsSinceEpoch}',
      localId: avaliacao.localId,
      usuarioId: avaliacao.usuarioId,
      usuarioNome: avaliacao.usuarioNome,
      usuarioFotoUrl: avaliacao.usuarioFotoUrl,
      nota: avaliacao.nota,
      comentario: avaliacao.comentario,
      dica: avaliacao.dica,
      data: DateTime.now(),
      curtidas: 0,
      usuariosQueCurtiram: [],
      fotosUrls: avaliacao.fotosUrls,
    );
    
    _avaliacoes.add(novaAvaliacao);
    print('✅ Nova avaliação adicionada por ${avaliacao.usuarioNome}');
    return novaAvaliacao;
  }
  
  Future<void> curtirAvaliacao(String avaliacaoId, String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final avaliacaoIndex = _avaliacoes.indexWhere((a) => a.id == avaliacaoId);
    
    if (avaliacaoIndex != -1) {
      final avaliacao = _avaliacoes[avaliacaoIndex];
      
      if (avaliacao.usuariosQueCurtiram.contains(usuarioId)) {
        // Descurtir
        avaliacao.usuariosQueCurtiram.remove(usuarioId);
        avaliacao.curtidas--;
        print('👎 Avaliação $avaliacaoId descurtida por usuário $usuarioId');
      } else {
        // Curtir
        avaliacao.usuariosQueCurtiram.add(usuarioId);
        avaliacao.curtidas++;
        print('👍 Avaliação $avaliacaoId curtida por usuário $usuarioId');
      }
    } else {
      print('❌ Avaliação não encontrada: $avaliacaoId');
    }
  }
  
  Future<bool> removerAvaliacao(String avaliacaoId, String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _avaliacoes.indexWhere(
      (a) => a.id == avaliacaoId && a.usuarioId == usuarioId,
    );
    
    if (index != -1) {
      _avaliacoes.removeAt(index);
      print('🗑️  Avaliação $avaliacaoId removida pelo usuário $usuarioId');
      return true;
    }
    
    return false;
  }

  // ========== FAVORITOS ==========
  Future<List<Favorito>> getFavoritosDoUsuario(String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _favoritos
        .where((favorito) => favorito.usuarioId == usuarioId)
        .toList();
  }
  
  Future<List<Local>> getLocaisFavoritosDoUsuario(String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final favoritosIds = _favoritos
        .where((f) => f.usuarioId == usuarioId)
        .map((f) => f.localId)
        .toList();
    
    return _locais.where((local) => favoritosIds.contains(local.id)).toList();
  }
  
  Future<Favorito?> adicionarFavorito(Favorito favorito) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Verificar se já é favorito
    if (_favoritos.any((f) => 
        f.usuarioId == favorito.usuarioId && f.localId == favorito.localId)) {
      print('⚠️  Local já está nos favoritos do usuário');
      return null;
    }
    
    final novoFavorito = Favorito(
      id: 'favorito_${DateTime.now().millisecondsSinceEpoch}',
      usuarioId: favorito.usuarioId,
      localId: favorito.localId,
      dataAdicao: DateTime.now(),
    );
    
    _favoritos.add(novoFavorito);
    print('❤️  Local ${favorito.localId} adicionado aos favoritos do usuário ${favorito.usuarioId}');
    return novoFavorito;
  }
  
  Future<bool> removerFavorito(String usuarioId, String localId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = _favoritos.indexWhere(
      (f) => f.usuarioId == usuarioId && f.localId == localId,
    );
    
    if (index != -1) {
      _favoritos.removeAt(index);
      print('💔 Local $localId removido dos favoritos do usuário $usuarioId');
      return true;
    }
    
    return false;
  }
  
  Future<bool> toggleFavorito(String usuarioId, String localId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final isFavorito = await this.isFavorito(usuarioId, localId);
    
    if (isFavorito) {
      return await removerFavorito(usuarioId, localId);
    } else {
      final favorito = Favorito(
        id: 'favorito_${DateTime.now().millisecondsSinceEpoch}',
        usuarioId: usuarioId,
        localId: localId,
        dataAdicao: DateTime.now(),
      );
      return await adicionarFavorito(favorito) != null;
    }
  }
  
  Future<bool> isFavorito(String usuarioId, String localId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _favoritos.any(
      (f) => f.usuarioId == usuarioId && f.localId == localId,
    );
  }

  // ========== UTILITÁRIOS ==========
  Future<void> limparDados() async {
    _users.clear();
    _locais.clear();
    _avaliacoes.clear();
    _favoritos.clear();
    _nextUserId = 1;
    print('🗑️  Todos os dados foram limpos');
  }
  
  Future<void> recarregarDados() async {
    await limparDados();
    _initializeSampleData();
    print('🔄 Dados recarregados com sucesso');
  }
  
  Future<Map<String, dynamic>> getEstatisticas() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return {
      'totalUsuarios': _users.length,
      'totalLocais': _locais.length,
      'totalAvaliacoes': _avaliacoes.length,
      'totalFavoritos': _favoritos.length,
      'mediaAvaliacoes': _avaliacoes.isNotEmpty
          ? _avaliacoes.map((a) => a.nota).reduce((a, b) => a + b) / _avaliacoes.length
          : 0.0,
      'locaisPorCategoria': {
        'ponto_turistico': _locais.where((l) => l.categoria == 'ponto_turistico').length,
        'restaurante': _locais.where((l) => l.categoria == 'restaurante').length,
        'shopping': _locais.where((l) => l.categoria == 'shopping').length,
      },
    };
  }
}