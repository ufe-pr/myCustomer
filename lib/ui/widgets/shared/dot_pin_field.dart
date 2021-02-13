import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



class PinField extends StatelessWidget {

  final String title;
  final Function(String s) onChange;
  final Function(String s) onCompleted;
  final Function(String s) onSubmitted;
  final Function(String s) validator;
  final TextEditingController textEditingController;
  final Function onUmatchedPins;


  const PinField({
    Key key,
    this.title,
    this.onChange,
    this.onCompleted,
    this.onSubmitted,
    this.validator,
    this.textEditingController,
    this.onUmatchedPins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void setValue(String value) {
      if (value.isEmpty) return;
      if (value == 'clear') {
        textEditingController.text = textEditingController.text
            .substring(0, textEditingController.text.length - 1);
      } 
      else {
        textEditingController.text = textEditingController.text + value;
      }
    }

   
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.yMargin(context, 3),
        horizontal: SizeConfig.xMargin(context, 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$title',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).appBarTheme.color,
              fontSize: SizeConfig.textSize(context, 4.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: SizeConfig.yMargin(context, 2.5),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.xMargin(context, 20),
            ),
            child: PinCodeTextField(
              focusNode: DisabledFocusNode(),
              length: 4,
              backgroundColor: const Color(0xFF333CC1),
              obsecureText: true,
              animationType: AnimationType.scale,
              textInputType: TextInputType.number,
              enableActiveFill: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.textSize(context, 5),
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(20),
                selectedFillColor: const Color.fromARGB(70, 255, 255, 255),
                activeFillColor: Colors.white,
                inactiveFillColor: const Color.fromARGB(70, 255, 255, 255),
                selectedColor: Colors.white,
                activeColor: Colors.white,
                inactiveColor: const Color.fromARGB(70, 255, 255, 255),
                borderWidth: 2,
                fieldWidth: 14,
              ),
              animationDuration: Duration(milliseconds: 300),
              //errorAnimationController: errorController,
              controller: textEditingController,
              autoDisposeControllers: false,
              onCompleted: onCompleted,
              onChanged: onChange,
              onSubmitted: onSubmitted,
              validator: validator,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      numButton(
                        context: context,
                        label: '1',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '2',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '3',
                        setValue: setValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      numButton(
                        context: context,
                        label: '4',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '5',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '6',
                        setValue: setValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      numButton(
                        context: context,
                        label: '7',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '8',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '9',
                        setValue: setValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      numButton(
                        context: context,
                        label: '',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: '0',
                        setValue: setValue,
                      ),
                      numButton(
                        context: context,
                        label: 'clear',
                        setValue: setValue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell numButton({
    BuildContext context,
    String label,
    void setValue(String value),
  }) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: Text(
            label,
            style: numStyle.copyWith(
              fontSize: SizeConfig.textSize(context, 5),
            ),
          ),
        ),
        height: SizeConfig.yMargin(context, 10),
        width: SizeConfig.yMargin(context, 10),
      ),
      onTap: () {
        setValue(label);
      },
    );
  }
}

const numStyle = TextStyle(
  color: ThemeColors.background,
  fontWeight: FontWeight.bold,
);

class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

// final NavigationService _navigationService = locator<NavigationService>();

//  Future navigateToAppLockSettingsPage() async {
//     await _navigationService.replaceWith(Routes.appLockSettingsViewRoute);
//   }