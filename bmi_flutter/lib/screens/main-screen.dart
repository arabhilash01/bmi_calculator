import 'package:bmi_flutter/screens/heightselector.dart';
import 'package:bmi_flutter/screens/widgets/age_selector.dart';
import 'package:bmi_flutter/screens/widgets/gender_selector.dart';
import 'package:bmi_flutter/screens/widgets/weight_selector.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 54, 52, 80),
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: GenderSelector(),
            ),
            Expanded(
              child: AgeSelector(),
            ),
            Expanded(
              flex: 3,
              child: WeightSelector(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HeightMeasurer();
                    },
                  ),
                );
              },
              child: Text('Next - >'),
            )
          ],
        ),
      ),
    );
  }
}
