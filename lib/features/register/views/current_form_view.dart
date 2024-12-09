import 'package:flutter/widgets.dart';
import 'package:ibank/core/widgets/logo_title.dart';

class CurrentFormView extends StatelessWidget {
  final String formTitle;
  final GlobalKey<FormState> formKey;
  final List<Widget> formFields;
  const CurrentFormView(
      {super.key,
      required this.formTitle,
      required this.formKey,
      required this.formFields});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: LogoTitle(text: formTitle),
          ),
          const SizedBox(height: 60),
          ...formFields,
        ],
      ),
    );
  }
}
