import 'package:bmi/models/model.dart';
import 'package:bmi/services/database.dart';
import 'package:bmi/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<List<BimMeasure>> results = [];
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text('Historique', style: TextStyle(color: Colors.black)),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.green),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: FutureBuilder<List<BimMeasure>>(
            future: DBService().fetchBimMeasures(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> children = [];
              if (snapshot.hasData) {
                print('Data : ${snapshot.data}');
                children = <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: buildChartHistory(snapshot.data)),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Error : ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[Loading()];
              }

              return Column(
                children: children,
              );
            }));
  }

  Widget buildChartHistory(List<BimMeasure> data) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Evolution de votre IMC'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<BimMeasure, double>(
            name: 'imc',
            dataSource: data,
            xValueMapper: (BimMeasure m, _) => m.id!.toDouble(),
            yValueMapper: (BimMeasure m, _) => m.bim,
            //dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true),
      ],
      primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
    );
  }
}
