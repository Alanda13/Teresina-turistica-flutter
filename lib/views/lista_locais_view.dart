import 'package:flutter/material.dart';
import '../models/local.dart';
import 'detalhes_local_view.dart'; // Importar a nova tela de detalhes
import '../controllers/global_controller.dart';

class ListaLocaisView extends StatelessWidget {
  ListaLocaisView({super.key});

  final List<Local> locais = [
    Local(
      id: 'ponte_estaiada_1', // ✅ Adicionar ID obrigatório
      nome: 'Ponte Estaiada',
      descricao: 'Ponto turístico com mirante',
      latitude: -5.070019,
      longitude: -42.802847,
      imagem: 'assets/images/ponte_estaiada.jpg',
      categoria: 'ponto_turistico', // ✅ Adicionar categoria
      endereco: 'Av. Raul Lopes, 1000 - Buenos Aires, Teresina - PI',
      horarioFuncionamento: '24 horas',
      notaMedia: 4.7,
      totalAvaliacoes: 125,
      tags: ['mirante', 'ar-livre', 'fotografia'],
    ),
    Local(
      id: 'encontro_rios_1',
      nome: 'Encontro dos Rios',
      descricao: 'Encontro do Rio Poti com o Parnaíba',
      latitude: -5.035189,
      longitude: -42.839174,
      imagem: 'assets/images/encontro_dos_rios.jpg',
      categoria: 'ponto_turistico',
      endereco: 'Margem do Rio Poti, Teresina - PI',
      notaMedia: 4.5,
      totalAvaliacoes: 89,
      tags: ['natureza', 'rio', 'pôr-do-sol'],
    ),
    Local(
      id: 'parque_potycabana_1',
      nome: 'Parque Potycabana',
      descricao: 'Área de lazer ao ar livre',
      latitude: -5.084599402633471,
      longitude: -42.792735293001925,
      imagem: 'assets/images/parque_potycabana.jpg',
      categoria: 'ponto_turistico',
      endereco: 'Av. Maranhão - Centro, Teresina - PI',
      horarioFuncionamento: '05:00-22:00',
      notaMedia: 4.3,
      totalAvaliacoes: 67,
      tags: ['parque', 'ar-livre', 'exercícios'],
    ),
    Local(
      id: 'shopping_rio_poty_1',
      nome: 'Shopping Rio Poty',
      descricao: 'Centro comercial e lazer',
      latitude: -5.07719,
      longitude: -42.80211,
      imagem: 'assets/images/shopping_rio_poty.jpg',
      categoria: 'shopping',
      endereco: 'Av. Raul Lopes, 1000 - Buenos Aires, Teresina - PI',
      horarioFuncionamento: '10:00-22:00',
      notaMedia: 4.4,
      totalAvaliacoes: 234,
      tags: ['compras', 'cinema', 'alimentação'],
    ),
    Local(
      id: 'igreja_sao_benedito_1',
      nome: 'Igreja São Benedito',
      descricao: 'Uma das mais antigas igrejas da cidade',
      latitude: -5.090303,
      longitude: -42.810996,
      imagem: 'assets/images/sao_benedito.jpg',
      categoria: 'ponto_turistico',
      endereco: 'Praça Saraiva - Centro, Teresina - PI',
      horarioFuncionamento: '07:00-18:00',
      notaMedia: 4.6,
      totalAvaliacoes: 56,
      tags: ['histórico', 'religioso', 'arquitetura'],
    ),
    Local(
      id: 'museu_piaui_1',
      nome: 'Museu do Piauí',
      descricao: 'História e cultura do estado do Piauí',
      latitude: -5.08974,
      longitude:  -42.8176,
      imagem: 'assets/images/museu_piaui.jpg',
      categoria: 'ponto_turistico',
      endereco: 'R. Coelho Rodrigues, 193 - Centro, Teresina - PI',
      horarioFuncionamento: '09:00-17:00',
      telefone: '(86) 3221-6027',
      notaMedia: 4.8,
      totalAvaliacoes: 42,
      tags: ['museu', 'história', 'cultura'],
    ),
    Local(
      id: 'teatro_4_setembro_1',
      nome: 'Teatro 4 de Setembro',
      descricao: 'Centro cultural e artístico tradicional',
      latitude: -5.091222,
      longitude: -42.81341,
      imagem: 'assets/images/teatro_4_setembro.jpg',
      categoria: 'ponto_turistico',
      endereco: 'R. Alvaro Mendes, 195 - Centro, Teresina - PI',
      telefone: '(86) 3216-3100',
      notaMedia: 4.5,
      totalAvaliacoes: 78,
      tags: ['teatro', 'cultura', 'arte'],
    ),
    Local(
      id: 'praca_pedro_ii_1',
      nome: 'Praça Pedro II',
      descricao: 'Praça histórica no centro de Teresina',
      latitude:  -5.09187,
      longitude:  -42.81292,
      imagem: 'assets/images/praca_pedro_segundo.jpg',
      categoria: 'ponto_turistico',
      endereco: 'Centro, Teresina - PI',
      notaMedia: 4.2,
      totalAvaliacoes: 91,
      tags: ['praça', 'histórico', 'centro'],
    ),
    // ==========================
    // 🍽️ RESTAURANTES
    // ==========================
    Local(
      id: 'coco_bambu_teresina_1',
      nome: 'Coco Bambu Teresina',
      descricao: 'Famoso por frutos do mar e ambiente familiar',
      latitude: -5.0697594,
      longitude: -42.7879956,
      imagem: 'assets/images/coco_bambu.jpg',
      categoria: 'restaurante',
      endereco: 'Av. João XXIII, 2555 - Jóquei, Teresina - PI',
      telefone: '(86) 3215-5555',
      horarioFuncionamento: '12:00-23:00',
      precoMedio: 80.0,
      notaMedia: 4.8,
      totalAvaliacoes: 342,
      tags: ['frutos-do-mar', 'familiar', 'alto-padrão'],
    ),
    // ✅ Adicionar mais restaurantes típicos
    /*Local(
      id: 'tia_rosa_1',
      nome: 'Tia Rosa Panelas & Temperos',
      descricao: 'Comida típica piauiense em ambiente acolhedor',
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
      tags: ['comida-típica', 'acolhedor', 'barato'],
    ),
    Local(
      id: 'cantinho_do_boi_1',
      nome: 'Cantinho do Boi',
      descricao: 'Melhor churrascaria de Teresina',
      latitude: -5.0832,
      longitude: -42.7995,
      imagem: 'assets/images/cantinho_do_boi.jpg',
      categoria: 'restaurante',
      endereco: 'Rua Governador Rocha Furtado, 477 - Centro, Teresina - PI',
      telefone: '(86) 3221-6565',
      horarioFuncionamento: '11:30-23:00',
      precoMedio: 60.0,
      notaMedia: 4.7,
      totalAvaliacoes: 289,
      tags: ['churrascaria', 'carnes', 'rodízio'],
    ),*/
  ];

  void _navegarParaDetalhes(BuildContext context, Local local) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetalhesLocalView(local: local)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locais de Teresina'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _mostrarFiltros(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: locais.length,
        itemBuilder: (context, index) {
          final local = locais[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => _navegarParaDetalhes(context, local),
              child: Row(
                children: [
                  // Miniatura do local com badge de categoria
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        child: local.imagem != null
                            ? Image.asset(
                                local.imagem!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey[300],
                                child: const Icon(Icons.place, size: 40),
                              ),
                      ),
                      // Badge de categoria
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getCorCategoria(local.categoria),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _getEmojiCategoria(local.categoria),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Texto do local com informações expandidas
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            local.nome,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Mostrar categoria e nota
                          Row(
                            children: [
                              Text(
                                _getNomeCategoria(local.categoria),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                local.notaMedia.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' (${local.totalAvaliacoes})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            local.descricao,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Mostrar preço médio para restaurantes
                          if (local.precoMedio != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '💰 R\$ ${local.precoMedio!.toStringAsFixed(2)} (média)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                          // Mostrar tags
                          // Alternativa com Chips funcionais
                          if (local.tags.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: local.tags
                                  .take(3)
                                  .map(
                                    (tag) => Chip(
                                      label: Text(
                                        tag,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 0,
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      backgroundColor: Colors.blue[50],
                                      labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCorCategoria(String categoria) {
    switch (categoria) {
      case 'restaurante':
        return Colors.orange;
      case 'ponto_turistico':
        return Colors.blue;
      case 'shopping':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getEmojiCategoria(String categoria) {
    switch (categoria) {
      case 'restaurante':
        return '🍽️';
      case 'ponto_turistico':
        return '🏛️';
      case 'shopping':
        return '🛍️';
      default:
        return '📍';
    }
  }

  String _getNomeCategoria(String categoria) {
    switch (categoria) {
      case 'restaurante':
        return 'Restaurante';
      case 'ponto_turistico':
        return 'Ponto Turístico';
      case 'shopping':
        return 'Shopping';
      default:
        return categoria;
    }
  }

  void _mostrarFiltros(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filtrar por Categoria',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.restaurant, color: Colors.orange),
                title: const Text('Restaurantes'),
                onTap: () {
                  Navigator.pop(context);
                  _filtrarPorCategoria(context, 'restaurante');
                },
              ),
              ListTile(
                leading: const Icon(Icons.landscape, color: Colors.blue),
                title: const Text('Pontos Turísticos'),
                onTap: () {
                  Navigator.pop(context);
                  _filtrarPorCategoria(context, 'ponto_turistico');
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.purple),
                title: const Text('Shoppings'),
                onTap: () {
                  Navigator.pop(context);
                  _filtrarPorCategoria(context, 'shopping');
                },
              ),
              ListTile(
                leading: const Icon(Icons.all_inclusive, color: Colors.green),
                title: const Text('Todos'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filtrarPorCategoria(BuildContext context, String categoria) {
    // Por enquanto, apenas mostra um snackbar
    // Em uma implementação real, você filtraria a lista
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filtrando por: $categoria'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
