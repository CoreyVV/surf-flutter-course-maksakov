import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final Widget child;
  final ImageChunkEvent? loadingProgress;

  const ProgressIndicator({
    required this.child,
    required this.loadingProgress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loadingProgress == null
        ? child
        : Center(
            child: CircularProgressIndicator(
              value: loadingProgress!.expectedTotalBytes != null
                  ? loadingProgress!.cumulativeBytesLoaded /
                      loadingProgress!.expectedTotalBytes!
                  : null,
            ),
          );
  }
}

//todo: найти использования и заменить на ProgressIndicator
// Widget loadingBuilder(
//   // BuildContext context,
//   Widget child,
//   ImageChunkEvent? loadingProgress,
// ) {
//   if (loadingProgress == null) {
//     return child;
//   }
//
//   return Center(
//     child: CircularProgressIndicator(
//       value: loadingProgress.expectedTotalBytes != null
//           ? loadingProgress.cumulativeBytesLoaded /
//               loadingProgress.expectedTotalBytes!
//           : null,
//     ),
//   );
// }
