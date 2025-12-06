import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../models/local.dart';

class MapsView extends StatefulWidget {
  final Local? localSelecionado;
  final List<Local>? todosLocais;

  const MapsView({
    super.key,
    this.localSelecionado,
    this.todosLocais,
  });

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? _mapController;
  final Set<Marker> _marcadores = {};

  // Modificação 1: Inicialização da _cameraPosition como late
  late LatLng _cameraPosition; // Removida a atribuição 'const' inicial

  @override
  void initState() {
    super.initState();
    // Define a posição inicial com base no local selecionado ou padrão (Teresina)
    _cameraPosition = widget.localSelecionado != null
        ? LatLng(widget.localSelecionado!.latitude, widget.localSelecionado!.longitude)
        : const LatLng(-5.0892, -42.8016); // Localização padrão Teresina

    _carregarMarcadores();
    // Modificação 2: Removida a chamada de _obterLocalizacao() daqui.
  }

  // ✅ Busca localização real do usuário e atualiza _cameraPosition
  Future<void> _obterLocalizacao() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    final posicao = await Geolocator.getCurrentPosition();

    setState(() {
      _cameraPosition = LatLng(
        posicao.latitude,
        posicao.longitude,
      );
    });
    // Modificação 3: Remove a chamada _mapController?.animateCamera(...) daqui
  }

  void _carregarMarcadores() {
    Set<Marker> novosMarcadores = {};
    if (widget.todosLocais != null) {
      for (var local in widget.todosLocais!) {
        novosMarcadores.add(
          Marker(
            markerId: MarkerId(local.nome),
            position: LatLng(local.latitude, local.longitude),
            infoWindow: InfoWindow(
              title: local.nome,
              snippet: local.descricao,
            ),
          ),
        );
      }
    }
    // Removida a redefinição de _cameraPosition, pois já é feita no initState
    // e tratada no onMapCreated.

    setState(() {
      _marcadores.addAll(novosMarcadores);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Teresina'),
        backgroundColor: const Color(0xFF00796B),
        foregroundColor: Colors.white,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _cameraPosition,
          zoom: 15,
        ),
        markers: _marcadores,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        // guarda referencia do mapa
        // Modificação 4: Lógica de centralização dentro do onMapCreated
        onMapCreated: (controller) async {
          _mapController = controller;

          // Se NENHUM local foi selecionado, centraliza na localização do usuário
          if (widget.localSelecionado == null) {
            await _obterLocalizacao(); // Atualiza _cameraPosition com a localização do usuário
            _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(_cameraPosition, 15),
            );
          } else {
            // Se um local foi selecionado, garante a centralização no local (que já foi
            // definido como _cameraPosition no initState)
             _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(_cameraPosition, 15),
            );
          }
        },
      ),
    );
  }
}