/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      domainAxis: new charts.DateTimeAxisSpec(
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
        minute: new charts.TimeFormatterSpec(
          format: 'HH:mm', // or even HH:mm here too
          transitionFormat: 'HH:mm',
        ),
      )),
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 00, 00), 15),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 1, 00), 15),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 2, 00), 5),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 3, 00), 25),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 4, 00), 45),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 5, 30), 5),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 10, 00), 25),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 15, 30), 20),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 4, 00), 10),

      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 00, 00), 15),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 00, 30), 5),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 01, 00), 25),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 01, 30), 20),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 02, 00), 15),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 02, 30), 5),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 03, 00), 25),
      // new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 03, 30), 20),
      new TimeSeriesSales(
          new DateTime(
            2018,
            8,
            22,
            13,
            05,
          ),
          15),
      new TimeSeriesSales(
          new DateTime(
            2018,
            8,
            22,
            13,
            5,
            10,
          ),
          35),
      new TimeSeriesSales(
          new DateTime(
            2018,
            8,
            22,
            13,
            06,
          ),
          15),
      new TimeSeriesSales(
          new DateTime(
            2018,
            8,
            22,
            13,
            07,
          ),
          5),
      new TimeSeriesSales(
          new DateTime(
            2018,
            8,
            22,
            13,
            08,
          ),
          25),
      new TimeSeriesSales(
          new DateTime(
            2018,
            8,
            22,
            13,
            09,
          ),
          15),

      //   new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 09, 20), 20),
      //   new TimeSeriesSales(new DateTime(2018, 8, 22, 13, 10, 00), 15),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
