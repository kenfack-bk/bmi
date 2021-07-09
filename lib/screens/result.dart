import 'package:bmi/models/model.dart';
import 'package:bmi/services/bim_service.dart';
import 'package:bmi/services/database.dart';
import 'package:flutter/material.dart';

class BimResult extends StatefulWidget {
  final BimMeasure measure;

  const BimResult({Key? key, required this.measure}) : super(key: key);
  @override
  _BimResultState createState() => _BimResultState();
}

class _BimResultState extends State<BimResult> {
  bool saved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text('Resultat', style: TextStyle(color: Colors.black)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.green),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          SizedBox(
            height: 10,
          ),
          showDescriptiveImage(),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text('Votre IMC est de '),
          ),
          SizedBox(
            height: 50,
          ),
          Center(child: Text(widget.measure.bim.toString())),
          SizedBox(
            height: 50,
          ),
          Center(child: Text(widget.measure.category)),
          SizedBox(
            height: 50,
          ),
          if (!saved)
            ElevatedButton(
                child: Text('Enregistrer cette mesure'),
                onPressed: () async {
                  await DBService().addNewBimMeasure(widget.measure);
                  setState(() {
                    this.saved = true;
                  });
                  this.showConfirmMessage();
                }),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
              child: Text('Calculer encore'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]),
      ),
    );
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

  Widget showDescriptiveImage() {
    BimService bimServ = new BimService();
    int cat = bimServ.category(widget.measure.bim);
    String imagePath = cat == 1 ? 'images/happy.jpg' : 'images/sad.jpg';
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              //fit: BoxFit.cover,
              image: AssetImage(imagePath))),
    );
  }
}
