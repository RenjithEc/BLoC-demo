import 'package:flutter/material.dart';
import './provider.dart';
import './piebloc.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  static Map<String, double> dataMap = new Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Flutter", () => 0);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);
  }

  void updatePie(double value) {
    bloc.updateSliderProvider(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart with BLoC'),
      ),
      body: StreamBuilder(
        stream: bloc.dataStream,
        initialData: SliderValueProvider().slidervalue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            children: <Widget>[
              PieChart(
                dataMap: dataMap,
                legendFontColor: Colors.blueGrey[900],
                legendFontSize: 14.0,
                legendFontWeight: FontWeight.w500,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                showChartValuesInPercentage: true,
                showChartValues: true,
                chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
                colorList: colorList,
                showLegends: true,
              ),
              Container(
                padding: new EdgeInsets.all(32.0),
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Text('Value: ${(snapshot.data * 100).round()}'),
                      new Slider(
                        value: snapshot.data,
                        onChanged: (double value) {
                          setState(
                            () {
                              updatePie(value);
                              dataMap.update("Flutter",
                                  (double val) => (snapshot.data) * 10);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
