import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onTap;

  const CircleImage({required this.image, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(color)),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          child: InkWell(
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) {
    return buildCircle(
        padding: 3,
        color: Colors.white,
        child: buildCircle(
          padding: 8,
          color: color,
          child: const Icon(
            Icons.edit,
            size: 20,
            color: Colors.white,
          ),
        ));
  }

  Widget buildCircle({
    required double padding,
    required Color color,
    required Widget child,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(padding),
        color: color,
        child: child,
      ),
    );
  }
}
