import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final String? text;
  final Function()? onTap;
  const LoginButton({super.key, required this.text, required this.onTap});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  Color _buttonBorderColor = Colors.transparent;

  void _changeColor() {
    setState(() {
      _buttonBorderColor = _buttonBorderColor == Colors.transparent
          ? Theme.of(context).colorScheme.tertiary
          : Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _changeColor();
        widget.onTap!();
      },
      child: Container(
        height: size.height / 17,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _buttonBorderColor, width: 2),
            color: Theme.of(context).colorScheme.inversePrimary),
        child: Center(
          child: Text(
            widget.text ?? "",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
