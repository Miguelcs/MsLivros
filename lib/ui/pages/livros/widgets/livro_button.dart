import 'package:flutter/material.dart';

class LivroButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool showProgress;

  const LivroButton(this.text, this.callback, {super.key, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    const backgroundColor1 = Color(0xFF0093c4);
    const backgroundColor2 = Color(0xFF0039cb);
    const textColor = Colors.white;

    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [backgroundColor1, backgroundColor2],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: TextButton(
        child: showProgress
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
        onPressed: callback,
      ),
    );
  }
}
