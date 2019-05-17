import 'dart:async';

import './provider.dart';

class PieBloc {
  // create a StreamController
  final pieController = StreamController();
  // create an instance of our Provider
  final SliderValueProvider provider = SliderValueProvider();
  // create a getter for our stream
  Stream get dataStream => pieController.stream;

  void updateSliderProvider(double value) {
    // call the method to update our slider value in the provider
    provider.valueupdate(value);
    // add the value to our sink
    pieController.sink.add(provider.slidervalue);
  }

  void dispose() {
    // close our StreamController
    pieController.close();
  }
}

// create an instance of the Pie bloc
final PieBloc bloc = PieBloc();
