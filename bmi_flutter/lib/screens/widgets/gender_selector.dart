import 'package:bmi_flutter/providers/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderSelector extends ConsumerWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(userProvider.select((value) => value.gender));
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Column(
        children: [
          const Text(
            'BMI Calculator',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(userProvider.notifier).updateGender(Gender.male);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 33, 55),
                          border: gender == Gender.male
                              ? const Border.fromBorderSide(BorderSide(color: Colors.white))
                              : Border.fromBorderSide(BorderSide(color: Colors.transparent)),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.male,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(userProvider.notifier).updateGender(Gender.female);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 32, 33, 55),
                          border: gender == Gender.female
                              ? const Border.fromBorderSide(BorderSide(color: Colors.white))
                              : Border.fromBorderSide(BorderSide(color: Colors.transparent)),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.female,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Female',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
