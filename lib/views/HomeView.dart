import 'package:flutter/material.dart';
import '../controllers/global_controller.dart';
import 'login_view.dart'; 
import 'maps_view.dart';
import 'lista_locais_view.dart'; // Importa a Lista de Locais

final _userController = userController;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _navigateToMaps(BuildContext context) {
    // Envia todos os locais para o MapsView
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapsView(todosLocais: ListaLocaisView().locais),
      ),
    );
  }

  void _navigateToListaLocais(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListaLocaisView()),
    );
  }

  void _logout(BuildContext context) {
    _userController.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginView()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00796B);
    final Color accentColor = const Color(0xFFFF8F00);

    return ListenableBuilder(
      listenable: _userController,
      builder: (context, child) {
        if (!_userController.isAuthenticated()) {
          return const Center(child: CircularProgressIndicator());
        }

        final userName = _userController.currentUser?.name.split(' ').first ?? 'Turista';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Teresina Turística'),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Sair da conta',
                onPressed: () => _logout(context),
              ),
            ],
          ),
          // ✅ CORREÇÃO: TROCAR Padding + Column POR ListView
          body: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                'Olá, $userName!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pronto(a) para explorar o que Teresina tem de melhor?',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Botão Mapas
              _MenuButton(
                title: 'Mapas de Teresina',
                subtitle: 'Pontos turísticos, restaurantes e sua localização.',
                icon: Icons.map,
                color: accentColor,
                onTap: () => _navigateToMaps(context),
              ),
              const SizedBox(height: 20),

              // Botão Lista de Locais
              _MenuButton(
                title: 'Lista de Locais',
                subtitle: 'Veja todos os pontos turísticos de Teresina',
                icon: Icons.list_alt,
                color: Colors.teal,
                onTap: () => _navigateToListaLocais(context),
              ),
              const SizedBox(height: 20),

              // Botão Perfil
              _MenuButton(
                title: 'Meu Perfil & Configurações',
                subtitle: 'Gerencie seus dados e status de usuário.',
                icon: Icons.person_outline,
                color: primaryColor.withOpacity(0.8),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Em breve: Tela de Perfil')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Botão Avaliações
              _MenuButton(
                title: 'Avaliações e Sugestões',
                subtitle: 'Veja o que outros turistas dizem sobre os locais.',
                icon: Icons.reviews_outlined,
                color: Colors.blueGrey,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Em breve: Tela de Avaliações')),
                  );
                },
              ),
              
              // ✅ ADICIONAR: Espaço extra no final para evitar overflow
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle, 
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}