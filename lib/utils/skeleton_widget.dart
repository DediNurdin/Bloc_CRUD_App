import 'package:flutter/material.dart';
import 'package:flutter_skeleton_plus/flutter_skeleton_plus.dart';

class SkeletonWidget {
  static gridSkeleton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          childAspectRatio: 0.79,
        ),
        itemBuilder: (context, index) {
          return SkeletonItem(
              child: Column(
            children: [
              Expanded(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: double.infinity,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    lines: 3,
                    spacing: 7,
                    lineStyle: SkeletonLineStyle(
                      height: 9,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width,
                    )),
              ),
            ],
          ));
        },
        itemCount: 8,
      ),
    );
  }

  static listSkeleton(
    BuildContext context,
    bool isHorizon,
    int itemCount,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: isHorizon ? Axis.horizontal : Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
            margin: isHorizon
                ? EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10)
                : EdgeInsets.only(left: 10, right: 10, bottom: 10),
            width: isHorizon ? 130 : double.infinity,
            height: 130,
            child: isHorizon
                ? SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        height: 130,
                        width: 130,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )
                : SkeletonItem(
                    child: Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            height: 60,
                            width: 60,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 3,
                                spacing: 4,
                                lineStyle: SkeletonLineStyle(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 6,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength: MediaQuery.of(context).size.width,
                                )),
                          ),
                        ],
                      ))
                    ],
                  )));
      },
      itemCount: itemCount,
    );
  }

  static chipSkeleton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15),
      child: Row(
        children: [
          SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  width: 100,
                  height: 35,
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          SizedBox(width: 8),
          SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  width: 100,
                  height: 35,
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          SizedBox(width: 8),
          SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  width: 100,
                  height: 35,
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ],
      ),
    );
  }

  static userAuthSkeleton(BuildContext context) {
    return Row(
      children: [
        SkeletonAvatar(
            style: SkeletonAvatarStyle(
          shape: BoxShape.circle,
          height: 75,
          width: 60,
        )),
        SizedBox(width: 8),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 3,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width,
                  )),
            ),
          ],
        ))
      ],
    );
  }
}
