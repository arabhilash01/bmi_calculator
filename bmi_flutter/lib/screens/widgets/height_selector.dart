import 'package:flutter/material.dart';

class HeightMeasurer extends StatefulWidget {
  @override
  _HeightMeasurerState createState() => _HeightMeasurerState();
}

class _HeightMeasurerState extends State<HeightMeasurer> {
  int height = 0;
  List<int> heightList = List.generate(200, (index) => index + 50);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(28.0),
          child: Text(
            'Select your Height',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 400,
              child: ListWheelScrollView(
                  itemExtent: 50,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      height = value;
                    });
                  },
                  diameterRatio: 1.5,
                  children: List<Widget>.generate(100, (index) {
                    return Text(
                      '${index + 50}',
                      style: TextStyle(color: Colors.white),
                    );
                  })),
            )
          ],
        ),
        ElevatedButton(onPressed: () {}, child: Text('Calculate BMI'))
      ],
    );
  }
}
