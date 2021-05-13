import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:wmc_scan_master/controllers/user_controller.dart';

class UserPage extends StatelessWidget {
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(child: GetX<UserController>(builder: (controller) {
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
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          validator: (name) {
                            if (name.isEmpty || name.length < 6) {
                              return 'Insira um nome válido';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(labelText: "Nome do Usuário"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (!GetUtils.isEmail(email)) {
                              return 'E-mail inválido!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "E-mail"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24, left: 40, right: 40),
                        child: TextFormField(
                          controller: controller.passController,
                          keyboardType: TextInputType.text,
                          validator: (pass) {
                            if (pass.isEmpty || pass.length < 6)
                              return 'Senha inválida';
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Senha"),
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
                          initialValue: controller.userEntrances,
                          onSaved: (value) {
                            if (value == null) return;

                            controller.userEntrances = value;
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
