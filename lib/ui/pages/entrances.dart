import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmc_scan_master/controllers/entrance_controller.dart';

class EntrancesPage extends StatelessWidget {
  final authController = Get.put(EntranceController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Portaria"),
        centerTitle: true,
      ),
      body: GetX<EntranceController>(
        init: EntranceController(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      validator: (name) {
                        if (name.isEmpty || name.length < 6) {
                          return 'Insira um nome válido';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: "Nome da Portaria"),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: controller.statusController,
                      keyboardType: TextInputType.number,
                      validator: (status) {
                        if (status.isEmpty) return 'Insira um status';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Status"),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: RaisedButton(
                      onPressed: controller.isloading
                          ? null
                          : controller.createEntrance,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          color: Color(0XFFffc107),
                        ),
                        padding: const EdgeInsets.all(0),
                        child: !controller.isloading
                            ? Text(
                                "Criar",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Color(0XFF003a8c)),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
