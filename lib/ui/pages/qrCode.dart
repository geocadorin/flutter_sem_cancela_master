import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/controllers/qrCode_controller.dart';

class QrCodePage extends StatelessWidget {
  final qrController = Get.put(QRCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Gerar QR Code"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetX<QRCodeController>(
                builder: (controller) {
                  return controller.idToGenerate.isNotEmpty
                      ? RepaintBoundary(
                          key: controller.containerKey,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 50,
                              right: 50,
                              top: 50,
                              bottom: 25,
                            ),
                            color: Colors.white,
                            child: Column(
                              children: [
                                BarcodeWidget(
                                  barcode: Barcode.qrCode(),
                                  color: Colors.black,
                                  data: qrController.idToGenerate.value,
                                  width: 200,
                                  height: 200,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Center(
                                    child: Text(
                                      controller.selected.value,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              SizedBox(height: 40),
              GetX<QRCodeController>(
                builder: (controller) {
                  return controller.isloading
                      ? Container()
                      : Row(
                          children: [
                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,
                                elevation: 10,
                                dropdownColor: Colors.white,
                                hint: Text(" Escolha uma Veículo "),
                                onChanged: (newValue) {
                                  qrController.setSelected(newValue);
                                },
                                value: qrController.selected.value,
                                items:
                                    qrController.listItem.map((selectedType) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      selectedType,
                                    ),
                                    value: selectedType,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                },
              ),
              GetX<QRCodeController>(
                builder: (controller) {
                  return controller.idToGenerate.isEmpty
                      ? controller.isloading
                          ? CircularProgressIndicator()
                          : Container()
                      : !controller.isloading
                          ? MaterialButton(
                              color: Colors.deepOrange,
                              child: Text(
                                "Salvar QR Code",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                controller.saveQrCode();
                              })
                          : CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
