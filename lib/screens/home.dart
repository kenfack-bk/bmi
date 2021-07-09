import 'package:bmi/models/model.dart';
import 'package:bmi/screens/history.dart';
import 'package:bmi/screens/result.dart';
import 'package:bmi/screens/settings.dart';
import 'package:bmi/services/bim_service.dart';
import 'package:bmi/utills/ui.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final BimService bimServ = new BimService();

  // Form values
  double? height = 0;
  double? weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          'IMC Calculator',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
              icon: Icon(Icons.person, color: Colors.green))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/heart.jpg'))),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        textInputDecoration('Entrer votre taille', 'En mètre')
                            .copyWith(
                      icon: Icon(Icons.assessment),
                    ),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      this.height = value.isEmpty ? 0 : double.parse(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Svp veillez renseigner votre taille';
                      } else {
                        if (double.parse(value) <= 0) {
                          return 'Svp veillez renseigner une valeur positive ( > 0)';
                        }
                        return null;
                      }
                    }),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      textInputDecoration('Entrer votre poids (Kg)', 'En Kg')
                          .copyWith(icon: Icon(Icons.line_weight_rounded)),
                  onChanged: (value) {
                    this.weight = value.isEmpty ? 0 : double.parse(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Svp veillez renseigner votre poids';
                    } else {
                      if (double.parse(value) <= 0) {
                        return 'Svp veillez renseigner une valeur positive ( > 0)';
                      }
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    child: Text('Calculer votre IMC'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        print('taille = $height et Poids = $weight');
                        double bim =
                            bimServ.computeBim(this.weight!, this.height!);
                        final BimMeasure measure = new BimMeasure(
                            weight: weight!,
                            height: height!,
                            bim: bim,
                            category:
                                bimServ.corpulences[bimServ.category(bim)],
                            date: DateTime.now());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BimResult(
                                  measure: measure,
                                )));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green, //const Color(0xff03dac6),
        foregroundColor: Colors.black,
        mini: true,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => History()));
        },
        child: Icon(Icons.assessment),
      ),
    );
  }
}
