import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VolumeSliderState(volume: 0.5);
}

class VolumeSliderState extends State<VolumeSlider> {
  double volume;
  VolumeSliderState({@required this.volume});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        FontAwesomeIcons.volumeUp,
        size: 10,
        color: Colors.white,
      ),
      Flexible(
        child: Slider(
            // autofocus: true,
            value: volume,
            min: 0,
            max: 1,
            divisions: 10,
            activeColor: Colors.green,
            inactiveColor: Colors.orange,
            onChangeEnd: (double newVolume) {
              print("OVA");
            },
            onChanged: (double newVolume) {
              setState(() {
                this.volume = newVolume;
              });
            }),
      ),
    ]);
  }
}
