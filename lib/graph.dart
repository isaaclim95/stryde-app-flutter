/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'services/globals.dart' as globals;

class PointsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});

  factory PointsLineChart.weightGraph() {
    List<WeightData> data = new List();
    var weightStart = globals.weight_data.length - 14;
    if(weightStart < 0){
      weightStart = 0;
    }

    for (int i = weightStart; i < globals.weight_data.length; i++) {
      data.add(new WeightData(i + 1 - weightStart, globals.weight_data[i]['weight']));
    }

    var graph = [
      new charts.Series<WeightData, int>(
        id: 'Weights',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WeightData w, _) => w.day,
        measureFn: (WeightData w, _) => w.weight,
        data: data,
      )
    ];
    return new PointsLineChart(
      graph,
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      behaviors: [
        new charts.ChartTitle('Entries',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Kilograms',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea),
      ],
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(zeroBound: false)),
    );
  }
}

/// Sample linear data type.
class WeightData {
  final int day;
  final double weight;

  WeightData(this.day, this.weight);
}
