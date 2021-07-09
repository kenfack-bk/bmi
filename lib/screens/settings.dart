import 'package:bmi/services/share_prefs.dart';
import 'package:bmi/utills/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? age;
  String? sexe;
  String? photo;
  int radioGroupId = 1;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    this.initProfileForm();
    radioGroupId = sexe == 'woman' ? 2 : 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text('Profile', style: TextStyle(color: Colors.black)),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.green),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.only(left: 16, top: 50, right: 16),
                  child: Column(
                    children: [
                      Column(children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 1))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250'))),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    print(
                                        'changement de  votre image de profile ...');
                                    _optionsDialogBox(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      color: Colors.green,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          initialValue: this.name,
                          keyboardType: TextInputType.text,
                          decoration: textInputDecoration('NOM COMPLET', ''),
                          // textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            this.name = value;
                          },
                        ),
                        Padding(
                          child: SpinBox(
                              min: 0,
                              max: 100,
                              value: this.age == null
                                  ? 20.0
                                  : this.age!.toDouble(),
                              onChanged: (value) {
                                this.age = value.toInt();
                              },
                              decoration: InputDecoration(
                                labelText: 'Age',
                                suffixText: 'ans',
                              ),
                              validator: (text) {
                                return text!.isEmpty ? 'Age invalide' : null;
                              }),
                          padding: const EdgeInsets.all(16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: radioGroupId,
                              onChanged: (value) {
                                this.setState(() {
                                  this.sexe = "man";
                                  radioGroupId = 1;
                                });
                              },
                            ),
                            Text(
                              'Homme',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            Radio(
                              value: 2,
                              groupValue: radioGroupId,
                              onChanged: (value) {
                                this.setState(() {
                                  this.sexe = "woman";
                                  radioGroupId = 2;
                                });
                              },
                            ),
                            Text(
                              'Femme',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print(
                                  'Nom complet = $name Age = $age  Sexe = $sexe Phot = $photo');
                              this.saveProfileData();
                              this.showConfirmMessage();
                            },
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ));
  }

  void initProfileForm() {
    this.name = SharePrefs.getName();
    this.sexe = SharePrefs.getSexe();
    this.photo = SharePrefs.getPhoto();
    this.age = SharePrefs.getAge();
  }

  void saveProfileData() {
    if (name != null) SharePrefs.setString(SharePrefs.nameKey, this.name!);
    if (sexe != null) SharePrefs.setString(SharePrefs.sexeKey, this.sexe!);
    if (photo != null) SharePrefs.setString(SharePrefs.photoKey, this.photo!);
    if (age != null) SharePrefs.setInt(SharePrefs.ageKey, this.age!);
  }

  void showConfirmMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sauvegarde effectuée avec succès'),
        duration: const Duration(seconds: 2),
        width: 300.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Future<void> _optionsDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change your favorite picture.'),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  InkWell(
                      child: new Text('Take from Camera'),
                      onTap: () {
                        takePicture(context);
                      }),
                  //openCamera,
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  InkWell(
                    child: new Text('Select from Gallery'),
                    onTap: () {
                      selectPicture(context);
                    }, //openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> takePicture(BuildContext context) async {
    print('Taking picture from Camera ...');
    await _picker.getImage(source: ImageSource.camera);

    print('End of picture taking.');
    Navigator.of(context).pop();
  }

  Future<void> selectPicture(BuildContext context) async {
    print('Selecting picture from Gallery ...');

    print('End of picture selecting.');
    Navigator.of(context).pop();
  }
}
