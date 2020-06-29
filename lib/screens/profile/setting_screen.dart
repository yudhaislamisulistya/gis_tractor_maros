import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:status_alert/status_alert.dart';
import 'package:thesisgisproject/blocs/user.dart';
import 'package:thesisgisproject/constants.dart';

class SettingScreen extends StatefulWidget {
  final String docId;
  final String fullname;
  final String email;
  final String numberPhone;
  SettingScreen({this.docId, this.fullname, this.email, this.numberPhone});
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.fullname);
    return new Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: new AppBar(
        backgroundColor: kPrimaryColor,
        title: new Text("Change Information Account"),
        elevation: 0,
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        initialValue: widget.fullname,
                        attribute: "fullname",
                        enabled: true,
                        decoration: InputDecoration(labelText: "Fullname"),
                        validators: [
                          FormBuilderValidators.required(errorText: "Nama Tidak Boleh Kosong"),
                        ],
                      ),
                      FormBuilderTextField(
                        initialValue: widget.email,
                        attribute: "email",
                        enabled: false,
                        decoration: InputDecoration(labelText: "Email"),
                        validators: [
                          FormBuilderValidators.required(errorText: "Email Tidak Boleh Kosong"),
                          FormBuilderValidators.email(errorText: "Harus Mengisikan Email"),
                        ],
                      ),
                      FormBuilderTextField(
                        initialValue: widget.numberPhone,
                        enabled: true,
                        attribute: "number_phone",
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Number Phone"),
                        validators: [
                          FormBuilderValidators.numeric(errorText: "Tidak Boleh Mengisikan Selain Angka"),
                          FormBuilderValidators.minLength(10),
                          FormBuilderValidators.maxLength(12),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    MaterialButton(
                      color: kPrimaryColor,
                      child: Text(
                        "Submit",
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_fbKey.currentState.saveAndValidate()) {
                          dynamic userData = {
                            "email": _fbKey.currentState.value["email"],
                            "nama_lengkap": _fbKey.currentState.value["fullname"],
                            "no_telp": _fbKey.currentState.value["number_phone"],
                            "updated_at": DateTime.now(),
                          };
                          userBloc.changeDataUser(widget.docId, userData);
                          return StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),
                            title: 'Success',
                            subtitle: 'Berhasil Mengubah Data',
                            configuration: IconConfiguration(icon: Icons.done),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      color: kPrimaryLightColor,
                      child: Text(
                        "Reset",
                        style: new TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        _fbKey.currentState.reset();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
