import 'package:flutter/material.dart';

import '../utils/base_color.dart';

class  DefaultButton extends StatelessWidget {

  String text;
  Function() onPressed;

  DefaultButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BASE_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Stack(
            children: [
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                   text,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
              ),
              Container(
                height: 50,
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ]
        ),
      );
  }
}
