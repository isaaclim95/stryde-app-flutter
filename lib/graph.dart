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
    for(int i = 0; i < globals.weight_data.length; i++){
      data.add(new WeightData(i+1, globals.weight_data[i].toDouble()));
    }

    var graph = [new charts.Series<WeightData, int>(
      id: 'Weights',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (WeightData w, _) => w.day,
      measureFn: (WeightData w, _) => w.weight,
      data: data,
    )];
    return new PointsLineChart(
      graph,
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
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