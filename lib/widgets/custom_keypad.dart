// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:telegram_v1/widgets/keypad_button.dart';

class CustomKeypad extends StatelessWidget {
  CustomKeypad({
    required this.controller,
  });

  TextEditingController controller;

  void addInput(String number) {
    if (controller.text.length > 13) return;
    controller.text = controller.text + number;
  }

  void backSpace() {
    if (controller.text.length > 0)
      controller.text =
          controller.text.substring(0, controller.text.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: KeypadButton(
                        number: "1",
                        text: "   ",
                        onPressed: () => addInput("1"))),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "2",
                        text: "ABC",
                        onPressed: () => addInput("2"))),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "3",
                        text: "DEF",
                        onPressed: () => addInput("3"))),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Flexible(
                    child: KeypadButton(
                        number: "4",
                        text: "GHI",
                        onPressed: () => addInput("4"))),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "5",
                        text: "JKL",
                        onPressed: () => addInput("5"))),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "6",
                        text: "MNO",
                        onPressed: () => addInput("6"))),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Flexible(
                    child: KeypadButton(
                        number: "7",
                        text: "PQRS",
                        onPressed: () => addInput("7"))),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "8",
                        text: "TUV",
                        onPressed: () => addInput("8"))),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "9",
                        text: "WXYZ",
                        onPressed: () => addInput("9"))),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Flexible(
                    child: SizedBox(
                  width: 120,
                )),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                    child: KeypadButton(
                        number: "0",
                        text: "+",
                        onPressed: () => addInput("0"))),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: KeypadButton(
                      icon: Icons.backspace,
                      onPressed: () => backSpace(),
                      onLongPress: () => controller.clear()),
                ),
              ],
            ),
          ],
        ));
  }
}
