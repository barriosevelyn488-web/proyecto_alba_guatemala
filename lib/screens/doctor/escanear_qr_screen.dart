import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/patient_linking_service.dart';

class EscanearQrScreen extends StatefulWidget {
  const EscanearQrScreen({super.key});

  @override
  State<EscanearQrScreen> createState() => _EscanearQrScreenState();
}

class _EscanearQrScreenState extends State<EscanearQrScreen> {
  final MobileScannerController _controller = MobileScannerController();
  final PatientLinkingService _linkingService = PatientLinkingService();
  bool _isProcessing = false;

  void _showPinDialog(String qrData) {
    final TextEditingController pinController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ingresar PIN'),
          content: TextField(
            controller: pinController,
            decoration: const InputDecoration(
              labelText: 'PIN del paciente',
              hintText: 'Ej. ALBA-1234',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isProcessing = false;
                _controller.start();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final pin = pinController.text.trim();
                if (pin.isEmpty) return;

                Navigator.of(context).pop();
                await _validateAndLink(qrData, pin);
              },
              child: const Text('Vincular'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _validateAndLink(String qrData, String pin) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final success = await _linkingService.validateAndLink(
      qrData: qrData,
      pin: pin,
      professionalId: 'doctor_123',
    );

    if (mounted) Navigator.of(context).pop(); // Cierra el indicador de carga

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paciente vinculado con éxito')),
        );
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al vincular: PIN inválido')),
        );
        setState(() {
          _isProcessing = false;
        });
        _controller.start();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR de Paciente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          if (_isProcessing) return;
          
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final qrData = barcode.rawValue;
            if (qrData != null) {
              setState(() {
                _isProcessing = true;
              });
              _controller.stop();
              _showPinDialog(qrData);
              break;
            }
          }
        },
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
