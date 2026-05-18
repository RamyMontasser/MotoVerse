import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/generated/l10n.dart';

class Roles extends StatelessWidget {
  const Roles({super.key, required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: AppColors.blueNormal,
          side: const BorderSide(strokeAlign: 1),
          value: value,
          onChanged: onChanged,
        ),

        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('login'),

            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).termsText,
                    style: TextStyles.cairoRegular14.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                  TextSpan(
                    text: S.of(context).termsLink,
                    style: TextStyles.cairoRegular14.copyWith(
                      color: AppColors.blueNormal,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed('log in');
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
