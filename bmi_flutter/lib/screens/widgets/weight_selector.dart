import 'package:bmi_flutter/providers/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeightSelector extends StatefulWidget {
  @override
  _WeightSelectorState createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  int _selectedAge = 25;
  final FixedExtentScrollController _scrollController = FixedExtentScrollController(initialItem: 50);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 32, 33, 55), borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: <double>[0.0, 0.2, 0.8, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: ListWheelScrollView(
                      controller: _scrollController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          ref.read(userProvider.notifier).updateWeight(index + 1);
                          _selectedAge = index + 1;
                        });
                      },
                      // scrollDirection: Axis.vertical,
                      useMagnifier: false,
                      diameterRatio: 2.5,
                      squeeze: 0.8,
                      offAxisFraction: 0.9,
                      perspective: 0.009,
                      children: List<Widget>.generate(
                        200,
                        (int index) {
                          return Center(
                              child: RotatedBox(
                                  quarterTurns: 1,
                                  // child: _scrollController.selectedItem != index
                                  child: _scrollController.hasClients && _scrollController.selectedItem == index
                                      ? Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.blueAccent,
                                                    Colors.blue,
                                                    Colors.white,
                                                  ])),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '${index + 1}',
                                                  style: const TextStyle(fontSize: 25),
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 5,
                                                  color: const Color.fromARGB(255, 54, 52, 80),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Text(
                                          '${index + 1}',
                                          style: const TextStyle(color: Colors.white),
                                        )));
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Weight',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 180,
                      child: Image.asset(
                        'assets/images/foot_left.png',
                        fit: BoxFit.cover,
                      )),
                  Image.asset(
                    width: 180,
                    'assets/images/foot_right.png',
                    fit: BoxFit.cover,
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}
