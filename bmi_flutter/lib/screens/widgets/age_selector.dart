import 'package:bmi_flutter/providers/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgeSelector extends StatefulWidget {
  @override
  _AgeSelectorState createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  int _selectedAge = 25;
  final FixedExtentScrollController _scrollController = FixedExtentScrollController(initialItem: 24);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Column(
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
                      ref.read(userProvider.notifier).updateAge(index + 1);
                      _selectedAge = index + 1;
                    });
                  },
                  // scrollDirection: Axis.vertical,
                  useMagnifier: false,
                  diameterRatio: 2.5,
                  squeeze: 0.8,
                  offAxisFraction: 0.5,
                  perspective: 0.005,
                  children: List<Widget>.generate(
                    99,
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
                                              width: 30,
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
              'Age',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    });
  }
}
