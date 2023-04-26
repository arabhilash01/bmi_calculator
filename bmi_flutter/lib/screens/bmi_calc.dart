import 'package:bmi_flutter/providers/bmiValues.dart';
import 'package:bmi_flutter/providers/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BmiCalculator extends ConsumerWidget {
  const BmiCalculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCondition = ref.watch(bmiValueProvider.select((value) => value.condition));
    final bmiValue = ref.watch(bmiValueProvider.select((value) => value.result));
    final user = ref.watch(userProvider.select((value) => value.age));
    final userH = ref.watch(userProvider.select((value) => value.height));
    final userW = ref.watch(userProvider.select((value) => value.weight));
    final userG = ref.watch(userProvider.select((value) => value.gender));
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 54, 52, 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Your BMI Score',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'Age: $user',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'Height: $userH',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'Weight: $userW',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'Gender: ${userG.name}',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _getColor(userCondition),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const SizedBox(
                    width: 200,
                    height: 200,
                  ),
                ),
                Text(
                  bmiValue.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                )
              ],
            ),
            Text(
              'Condition: ${userCondition.name}',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ref.read(bmiValueProvider.notifier).reset();
                  ref.read(userProvider.notifier).reset();
                },
                child: const Text('Calculate again!!'))
          ],
        ),
      ),
    );
  }

  Color _getColor(Condition condition) {
    switch (condition) {
      case Condition.notspecified:
        return Colors.blue;
      case Condition.underweight:
        return Colors.yellow;
      case Condition.perfect:
        return Colors.green;
      case Condition.overweight:
        return Colors.orange;
      case Condition.obese:
        return Colors.red;
    }
  }
}
