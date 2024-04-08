import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: Colors.white, // Border color
                  borderRadius: 10, // Border radius
                  borderLength: 20, // Border length
                  borderWidth: 5, // Border width
                  cutOutSize: 250.0, // Size of the scanner area
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * -0.8,
            bottom: 16,
            left: 10,
            child: Container(
              height: 70,
              width: 70,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.flashlight_on, color: Colors.white),
                onPressed: () async{
                  await controller?.toggleFlash();
                  // Toggle flashlight
                  
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.flip_camera_ios_sharp, color: Colors.white),
                onPressed: ()async {
                  // Switch camera
                  await controller?.flipCamera();

                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          String? text=result!.code;
          // Do something with the result, for example:
          Navigator.pop(context,text);
          print(text!); // Print the scanned QR code
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
