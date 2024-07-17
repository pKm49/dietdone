import 'package:diet_diet_done/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionShimmerLoader extends StatelessWidget {
  const SubscriptionShimmerLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5, // Adjust this based on how many shimmer items you want
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: 190,
              width: 260,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => kHeight(5),
    );
  }
}
