import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Features/community/data/models/problem_type_model.dart';
import 'package:motoverse/Features/community/presentation/widgets/problem_type_card.dart';

class ProblemTypesGrid extends StatelessWidget {
  const ProblemTypesGrid({
    super.key,
    required this.selectedIndex,
    required this.problemTypes,
    required this.onChoose,
  });

  final int? selectedIndex;
  final List<ProblemTypeModel> problemTypes;
  final Function(int) onChoose;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 8.h,
        mainAxisExtent: 85.h,
      ),
      itemCount: problemTypes.length,
      itemBuilder: (context, index) {
        return ProblemTypeCard(
          title: problemTypes[index].title,
          iconPath: problemTypes[index].iconPath,
          isSelected: selectedIndex == index,
          onTap:(){ onChoose(index);},
        );
      },
    );
  }
}
