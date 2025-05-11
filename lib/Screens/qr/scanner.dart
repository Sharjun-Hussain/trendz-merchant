import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String scannedData = "No QR code scanned yet";
  bool _isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Qr',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 60, bottom: 60),
              child: MobileScanner(
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    final String? data = barcode.rawValue;
                    setState(() {
                      scannedData = barcode.rawValue ?? "No data found";
                    });

                    if (!_isScanned && data != null) {
                      _isScanned = true; // Prevent further detections
                      _showAlertAndClose(data); // Show alert and close scanner
                    }
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                scannedData,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertAndClose(String data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Scanned Successfully'),
          content: Text('QR Data: $data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context, data); // Close the scanner page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
