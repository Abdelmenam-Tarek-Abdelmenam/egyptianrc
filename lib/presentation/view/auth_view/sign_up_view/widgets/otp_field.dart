import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatelessWidget {
  const OtpField(this.onComplete, {Key? key}) : super(key: key);
  final Function(String) onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PinCodeTextField(
          // controller: controller,
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.transparent,
            selectedFillColor: Colors.transparent,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveFillColor: Colors.grey.withOpacity(0.3),
            inactiveColor:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          onCompleted: onComplete,
          onChanged: (_) {},
          beforeTextPaste: (_) => true,
        ));
  }
}
