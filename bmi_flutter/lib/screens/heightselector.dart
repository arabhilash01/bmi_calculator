import 'package:bmi_flutter/providers/bmiValues.dart';
import 'package:bmi_flutter/providers/userdetails.dart';
import 'package:bmi_flutter/screens/bmi_calc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeightMeasurer extends StatefulWidget {
  @override
  _HeightMeasurerState createState() => _HeightMeasurerState();
}

class _HeightMeasurerState extends State<HeightMeasurer> {
  int height = 0;
  List<int> heightList = List.generate(200, (index) => index + 50);
  final FixedExtentScrollController _scrollController = FixedExtentScrollController(initialItem: 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final heightValue = ref.watch(userProvider.select((value) => value.height));
        return Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 54, 52, 80),
          child: Column(
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$heightValue cms',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    width: 30,
                    height: 600,
                    child: ListWheelScrollView(
                        controller: _scrollController,
                        magnification: 1.5,
                        useMagnifier: true,
                        offAxisFraction: 0,
                        itemExtent: 20,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (value) {
                          ref.read(userProvider.notifier).updateHeight(value + 50);
                        },
                        diameterRatio: 9.5,
                        children: List<Widget>.generate(151, (index) {
                          if ((index + 50) % 5 == 0) {
                            return Text(
                              '${index + 50}',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          return const Text(
                            '----',
                            style: TextStyle(color: Colors.white),
                          );
                        })),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _calculateBMI(ref, ref.watch(userProvider).weight, ref.watch(userProvider).height,
                        ref.watch(userProvider).age, ref.watch(userProvider).gender);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BmiCalculator(),
                        ));
                  },
                  child: const Text('Calculate BMI'))
            ],
          ),
        );
      }),
    );
  }
}

void _calculateBMI(WidgetRef ref, int weight, int height, int age, Gender gender) {
  double bmi = 0;
  double heightInMeters = height / 100.0;
  bmi = (weight / (heightInMeters * heightInMeters));
  // if (gender == Gender.male) {
  //   bmi = 88.36 + (13.4 * weight) + (4.8 * heightInMeters) - (5.7 * age);
  // } else {
  //   bmi = 447.6 + (9.2 * weight) + (3.1 * heightInMeters) - (4.3 * age);
  // }

  print(bmi);

  if (bmi < 18.5) {
    ref.read(bmiValueProvider.notifier).update(bmi, Condition.underweight);
  } else if (bmi >= 18.5 && bmi < 25) {
    ref.read(bmiValueProvider.notifier).update(bmi, Condition.perfect);
  } else if (bmi >= 25 && bmi < 30) {
    ref.read(bmiValueProvider.notifier).update(bmi, Condition.overweight);
  } else {
    ref.read(bmiValueProvider.notifier).update(bmi, Condition.obese);
  }
}
