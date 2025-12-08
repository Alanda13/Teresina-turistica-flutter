import 'package:flutter/material.dart';
import '../models/local.dart';
import '../models/avaliacao_model.dart';
import '../controllers/global_controller.dart';

// Importar ambos os controllers
final _localController = localController;
final _userController = userController; // ✅ Adicionar userController

class DetalhesLocalView extends StatefulWidget {
  final Local local;
  
  const DetalhesLocalView({
    super.key,
    required this.local,
  });

  @override
  State<DetalhesLocalView> createState() => _DetalhesLocalViewState();
}

class _DetalhesLocalViewState extends State<DetalhesLocalView> {
  List<Avaliacao> _avaliacoes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarAvaliacoesComDebug();
  }

  Future<void> _carregarAvaliacoesComDebug() async {
    print('\n=== DEBUG DETALHES LOCAL VIEW ===');
    print('🔍 Local recebido: ${widget.local.nome}');
    print('🔍 ID do local: ${widget.local.id}');
    print('🔍 Categoria: ${widget.local.categoria}');
    
    // 1. Verificar se o controller está inicializado
    print('\n📊 Status do LocalController:');
    print('• Locais carregados: ${_localController.locais.length}');
    print('• Avaliações no controller: ${_localController.avaliacoes.length}');
    
    // 2. Tentar pegar avaliações do controller
    print('\n🔎 Buscando avaliações pelo controller...');
    final avaliacoesController = _localController.getAvaliacoesPorLocal(widget.local.id);
    print('• Avaliações encontradas: ${avaliacoesController.length}');
    
    // 3. Listar IDs das avaliações encontradas
    if (avaliacoesController.isNotEmpty) {
      print('📝 IDs das avaliações:');
      for (var avaliacao in avaliacoesController) {
        print('  • ${avaliacao.id} - ${avaliacao.usuarioNome}');
      }
    }
    
    // 4. Testar IDs de locais que TEM avaliações no DatabaseService
    print('\n🎯 Locais que TEM avaliações no sistema:');
    print('• ponte_estaiada_1 - Ponte Estaiada (2 avaliações)');
    print('• coco_bambu_teresina_1 - Coco Bambu (2 avaliações)');
    print('• encontro_rios_1 - Encontro dos Rios (1 avaliação)');
    print('• tia_rosa_1 - Tia Rosa (1 avaliação)');
    print('• cantinho_do_boi_1 - Cantinho do Boi (1 avaliação)');
    
    // 5. Verificar match de IDs
    print('\n✅ Verificando match de IDs...');
    final locaisComAvaliacoes = ['ponte_estaiada_1', 'coco_bambu_teresina_1', 'encontro_rios_1', 'tia_rosa_1', 'cantinho_do_boi_1'];
    if (locaisComAvaliacoes.contains(widget.local.id)) {
      print('🎉 MATCH ENCONTRADO! Este local TEM avaliações no sistema.');
    } else {
      print('⚠️  Este local NÃO TEM avaliações registradas ainda.');
    }
    
    setState(() {
      _avaliacoes = avaliacoesController;
      _isLoading = false;
    });
    
    print('====================================\n');
  }

  // Método ALTERNATIVO para testar avaliações hardcoded
  List<Avaliacao> _getAvaliacoesTeste() {
    return [
      Avaliacao(
        id: 'teste_1',
        localId: widget.local.id,
        usuarioId: '999',
        usuarioNome: 'Alanda (Teste)',
        nota: 4.5,
        comentario: 'Este é um comentário de teste para ${widget.local.nome}. O sistema de avaliações está funcionando!',
        dica: 'Dica de teste: Visite durante a tarde para melhor experiência.',
        data: DateTime.now(),
        curtidas: 3,
        usuariosQueCurtiram: [],
      ),
      Avaliacao(
        id: 'teste_2',
        localId: widget.local.id,
        usuarioId: '1000',
        usuarioNome: 'Visitante Teste',
        nota: 5.0,
        comentario: 'Local incrível! As avaliações estão carregando corretamente.',
        dica: 'Não esqueça de tirar muitas fotos!',
        data: DateTime.now().subtract(Duration(days: 1)),
        curtidas: 1,
        usuariosQueCurtiram: [],
      ),
    ];
  }

  void _toggleFavorito() {
    if (_userController.currentUser != null) {
      final userId = _userController.currentUser!.id.toString();
      _localController.toggleFavorito(widget.local.id, userId);
      setState(() {}); // Atualiza a UI
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Faça login para favoritar locais'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  bool _isFavorito() {
    if (_userController.currentUser == null) return false;
    final userId = _userController.currentUser!.id.toString();
    return _localController.isFavorito(widget.local.id, userId);
  }

  void _curtirAvaliacao(Avaliacao avaliacao) {
    if (_userController.currentUser != null) {
      final userId = _userController.currentUser!.id.toString();
      _localController.curtirAvaliacao(avaliacao.id, userId);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Faça login para curtir avaliações'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  bool _usuarioCurtiuAvaliacao(Avaliacao avaliacao) {
    if (_userController.currentUser == null) return false;
    final userId = _userController.currentUser!.id.toString();
    return avaliacao.usuarioCurtiu(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.local.nome),
        actions: [
          // Botão de debug/teste
          IconButton(
            icon: Icon(Icons.bug_report, color: Colors.yellow[700]),
            onPressed: () {
              setState(() {
                _avaliacoes = _getAvaliacoesTeste();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Carregadas ${_avaliacoes.length} avaliações de teste'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            tooltip: 'Carregar avaliações de teste',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner de debug (só aparece se não tiver avaliações)
            if (_avaliacoes.isEmpty && !_isLoading)
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.orange[50],
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MODO DEBUG',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[800],
                            ),
                          ),
                          Text(
                            'Local: ${widget.local.id} | Avaliações reais: 0',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () => _carregarAvaliacoesComDebug(),
                            child: Text('Recarregar'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            
            // Imagem do local
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _getColorForCategoria(widget.local.categoria),
                    _getColorForCategoria(widget.local.categoria).withOpacity(0.7),
                  ],
                ),
                color: Colors.grey[300],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.local.categoria == 'restaurante' 
                      ? Icons.restaurant 
                      : Icons.place,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.local.nome,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.local.categoria.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            // Informações básicas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho com nota
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  '${widget.local.notaMedia.toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${widget.local.totalAvaliacoes} avaliações',
                              style: TextStyle(
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                        Chip(
                          label: Text(
                            widget.local.categoria == 'restaurante' 
                              ? '🍽️ RESTAURANTE' 
                              : widget.local.categoria == 'ponto_turistico'
                                ? '🏛️ PONTO TURÍSTICO'
                                : widget.local.categoria.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: _getColorForCategoria(widget.local.categoria),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Descrição
                  Text(
                    'Sobre',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.local.descricao,
                    style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[700]),
                  ),
                  
                  // Informações adicionais
                  SizedBox(height: 24),
                  Text(
                    'Informações',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  if (widget.local.endereco != null) 
                    _infoItem(Icons.location_on, 'Endereço', widget.local.endereco!),
                  
                  if (widget.local.telefone != null) 
                    _infoItem(Icons.phone, 'Telefone', widget.local.telefone!),
                  
                  if (widget.local.horarioFuncionamento != null) 
                    _infoItem(Icons.access_time, 'Horário', widget.local.horarioFuncionamento!),
                  
                  if (widget.local.precoMedio != null) 
                    _infoItem(Icons.attach_money, 'Preço médio', 'R\$${widget.local.precoMedio!.toStringAsFixed(2)}'),
                  
                  // Tags
                  if (widget.local.tags.isNotEmpty) ...[
                    SizedBox(height: 20),
                    Text(
                      'Características',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: widget.local.tags
                          .map((tag) => Chip(
                                label: Text(
                                  '#$tag',
                                  style: TextStyle(fontSize: 12),
                                ),
                                backgroundColor: Colors.blue[50],
                                visualDensity: VisualDensity.compact,
                              ))
                          .toList(),
                    ),
                  ],
                  
                  // Botões de ação
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _toggleFavorito,
                          icon: Icon(
                            _isFavorito() ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorito() ? Colors.red : Colors.white,
                          ),
                          label: Text(
                            _isFavorito() ? 'FAVORITADO' : 'FAVORITAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isFavorito() ? Colors.red : Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFavorito() ? Colors.red[50] : Colors.red,
                            foregroundColor: _isFavorito() ? Colors.red : Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_userController.currentUser != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Tela de avaliações em desenvolvimento'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Faça login para avaliar'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.rate_review, color: Colors.white),
                          label: Text(
                            'AVALIAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Avaliações
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'AVALIAÇÕES',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            letterSpacing: 1,
                          ),
                        ),
                        Spacer(),
                        if (_avaliacoes.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_avaliacoes.length} avaliações',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  if (_isLoading)
                    Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Carregando avaliações...',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  else if (_avaliacoes.isEmpty)
                    // Mensagem quando não há avaliações
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.reviews, size: 64, color: Colors.grey[400]),
                          SizedBox(height: 16),
                          Text(
                            'Nenhuma avaliação ainda',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Seja o primeiro a compartilhar sua experiência sobre ${widget.local.nome}!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Carregar avaliações de teste
                              setState(() {
                                _avaliacoes = _getAvaliacoesTeste();
                              });
                            },
                            icon: Icon(Icons.visibility),
                            label: Text('Ver avaliações de teste'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    // Lista de avaliações
                    Column(
                      children: _avaliacoes.map((avaliacao) => _buildAvaliacaoCard(avaliacao)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _infoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAvaliacaoCard(Avaliacao avaliacao) {
    final usuarioCurtiu = _usuarioCurtiuAvaliacao(avaliacao);
    
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho da avaliação
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  radius: 22,
                  child: Text(
                    avaliacao.usuarioNome.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        avaliacao.usuarioNome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            avaliacao.nota.toStringAsFixed(1),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '•',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${_formatarData(avaliacao.data)}',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Comentário
            SizedBox(height: 16),
            Text(
              avaliacao.comentario,
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
            
            // Dica (se houver)
            if (avaliacao.dica != null && avaliacao.dica!.isNotEmpty) ...[
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[100]!, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.green[700], size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DICA DO LOCAL',
                            style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            avaliacao.dica!,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            // Ações (curtir/reportar)
            SizedBox(height: 16),
            Row(
              children: [
                // Botão curtir
                TextButton.icon(
                  onPressed: () => _curtirAvaliacao(avaliacao),
                  icon: Icon(
                    usuarioCurtiu ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: usuarioCurtiu ? Colors.blue : Colors.grey[600],
                    size: 18,
                  ),
                  label: Text(
                    'Curtir',
                    style: TextStyle(
                      color: usuarioCurtiu ? Colors.blue : Colors.grey[600],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '${avaliacao.curtidas}',
                  style: TextStyle(
                    color: usuarioCurtiu ? Colors.blue : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Spacer(),
                
                // Botão reportar
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Funcionalidade em desenvolvimento')),
                    );
                  },
                  icon: Icon(Icons.flag_outlined, size: 16, color: Colors.grey[600]),
                  label: Text(
                    'Reportar',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatarData(DateTime data) {
    final now = DateTime.now();
    final difference = now.difference(data);
    
    if (difference.inDays == 0) {
      return 'Hoje';
    } else if (difference.inDays == 1) {
      return 'Ontem';
    } else if (difference.inDays < 7) {
      return 'Há ${difference.inDays} dias';
    } else {
      return '${data.day}/${data.month}/${data.year}';
    }
  }
  
  Color _getColorForCategoria(String categoria) {
    switch (categoria) {
      case 'restaurante': return Colors.orange;
      case 'ponto_turistico': return Colors.blue;
      case 'hotel': return Colors.purple;
      case 'shopping': return Colors.pink;
      default: return Colors.grey;
    }
  }
}