import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerarQrScreen extends StatefulWidget {
  const GenerarQrScreen({super.key});

  @override
  State<GenerarQrScreen> createState() => _GenerarQrScreenState();
}

class _GenerarQrScreenState extends State<GenerarQrScreen> {
  final String codigoAcceso = "ALBA-911";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vincular Paciente"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Icon(
              Icons.qr_code_2,
              size: 70,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              "Escanea este código QR",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: QrImageView(
                  data: codigoAcceso,
                  version: QrVersions.auto,
                  size: 250,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Código de Acceso Rápido",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: Center(
                child: Text(
                  codigoAcceso,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text(
                  "Copiar / Usar Código de Acceso Rápido",
                ),
                onPressed: () async {

                  await Clipboard.setData(
                    ClipboardData(text: codigoAcceso),
                  );

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Código copiado al portapapeles",
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 35),

            const Divider(),

            const SizedBox(height: 20),

            const Text(
              "Si el doctor o el abuelito no pueden escanear el QR,\npueden ingresar el siguiente código manualmente:",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            SelectableText(
              codigoAcceso,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

          ],
        ),
      ),
    );
  }
}