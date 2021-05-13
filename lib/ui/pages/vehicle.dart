import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:wmc_scan_master/controllers/vehicle_controller.dart';
//import 'package:wmc_scan_master/controllers/user_controller.dart';

class VehiclePage extends StatelessWidget {
  final vehicleController = Get.put(VehicleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(child: GetX<VehicleController>(builder: (controller) {
          return !controller.isloading
              ? Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.documentController,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Insira um documento válido';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Documento do Veículo"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.colorController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Insira uma cor';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Cor"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty || val.length < 6)
                              return 'Nome inválido';
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Nome"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.modelController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty || val.length < 3)
                              return 'Modelo invalido';
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Modelo"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.plateController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty || val.length < 6)
                              return 'Placa invalido';
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Placa"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.sectorController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) return 'Setor invalido';
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Setor"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(40),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          chipBackGroundColor: Colors.blue,
                          chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.blue,
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: Text(
                            "Portarias Liberadas",
                            style: TextStyle(fontSize: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Selecione ao menos uma';
                            }
                            return null;
                          },
                          dataSource: controller.entrances,
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCELAR',
                          hintWidget: Text('Selecione uma ou mais Portarias'),
                          initialValue: controller.vehicleEntrances,
                          onSaved: (value) {
                            if (value == null) return;

                            controller.vehicleEntrances = value;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 16, left: 40, right: 40, bottom: 80),
                        child: ElevatedButton(
                          child: Text('Criar'),
                          onPressed: () {
                            controller.saveForm();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 80),
                      child: CircularProgressIndicator()),
                );
        })),
      ),
    );
  }
}
