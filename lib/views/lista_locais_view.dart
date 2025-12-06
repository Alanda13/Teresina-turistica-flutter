import 'package:flutter/material.dart';
import '../models/local.dart';
import 'maps_view.dart';

class ListaLocaisView extends StatelessWidget {
  ListaLocaisView({super.key});

  final List<Local> locais = [
    Local(
      nome: 'Ponte Estaiada',
      descricao: 'Ponto turístico com mirante',
      latitude: -5.0808,
      longitude: -42.8048,
      imagem: 'assets/images/ponte_estaiada.jpg',
    ),
    Local(
      nome: 'Encontro dos Rios',
      descricao: 'Encontro do Rio Poti com o Parnaíba',
      latitude: -5.0871,
      longitude: -42.8089,
      imagem: 'assets/images/encontro_dos_rios.jpg',
    ),
    Local(
      nome: 'Parque Potycabana',
      descricao: 'Área de lazer ao ar livre',
      latitude: -5.0902,
      longitude: -42.8019,
      imagem: 'assets/images/parque_potycabana.jpg',
    ),
    Local(
      nome: 'Shopping Rio Poty',
      descricao: 'Centro comercial e lazer',
      latitude: -5.0879,
      longitude: -42.8037,
      imagem: 'assets/images/shopping_rio_poty.jpg',
    ),
    Local(
      nome: 'Igreja São Benedito',
      descricao: 'Uma das mais antigas igrejas da cidade',
      latitude: -5.0913,
      longitude: -42.8052,
      imagem: 'assets/images/sao_benedito.jpg',
    ),
    Local(
      nome: 'Museu do Piauí',
      descricao: 'História e cultura do estado do Piauí',
      latitude: -5.0909,
      longitude: -42.8014,
      imagem: 'assets/images/museu_piaui.jpg',
    ),
    Local(
      nome: 'Teatro 4 de Setembro',
      descricao: 'Centro cultural e artístico tradicional',
      latitude: -5.0904,
      longitude: -42.8035,
      imagem: 'assets/images/teatro_4_setembro.jpg',
    ),
    Local(
      nome: 'Praça Pedro II',
      descricao: 'Praça histórica no centro de Teresina',
      latitude: -5.0905,
      longitude: -42.8037,
      imagem: 'assets/images/praca_pedro_segundo.jpg',
    ),
    // ==========================
    // 🍽️ RESTAURANTES
    // ==========================

    Local(
      nome: 'Coco Bambu Teresina',
      descricao: 'Famoso por frutos do mar e ambiente familiar',
      latitude: -5.0856,
      longitude: -42.7976,
      imagem: 'assets/images/coco_bambu.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locais de Teresina')),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapsView(
                      localSelecionado: local,
                      todosLocais: locais,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  // Miniatura do local
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
                  const SizedBox(width: 16),
                  // Texto do local
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                          const SizedBox(height: 8),
                          Text(
                            local.descricao,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
