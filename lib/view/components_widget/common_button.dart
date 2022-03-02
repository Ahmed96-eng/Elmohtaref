import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  /// Is the height of container box.
  /// Default is 15
  final double height;

  /// Is the height of container box.
  /// Default is 15
  final double width;

  /// Is the font size of the text.
  /// default is 14
  final double fontSize;

  /// Is an array of dx and dy positions
  /// Top is 0 dy, Center is 0.5 dy and Bottom is 1.0 dy
  /// left is 0.0 dx, Center is 0.5 dx and Right is 1.0 dx
  /// Default is [0.5,0.5] Centered
  final List<double> alignmentXY;

  /// Is the position of the text below or above the image
  final String position;

  /// is the corners of the box.
  /// starting from topLeft, topRight, bottomLeft and bottomRight

  /// Is the text to be displayed in the box
  final String? text;

  /// Is the color of text.
  /// Default is FFFFFF
  final Color? textColor;

  /// Is the color of the main container box.
  /// Default is FFFFFF
  final Color? containerColor;

  /// Is the image source which will be inside the container box
  final String? imageSource;
  final Color? borderColor;

  /// A function to be triggered when the user click on the box
  final VoidCallback? onTap;

  const CommonButton({
    Key? key,
    this.height = 60,
    this.width = 100,
    this.fontSize = 14,
    this.alignmentXY = const [0.5, 0.5],
    this.position = 'down',
    this.containerColor,
    this.textColor,
    this.imageSource,
    required this.text,
    required this.onTap,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FittedBox(
        child: Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(color: borderColor!),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Align(
                alignment: FractionalOffset(alignmentXY[0], alignmentXY[1]),
                child: Text(
                  text!,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (imageSource != null) ...[
                // SizedBox(width: 32),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    imageSource!,
                    fit: BoxFit.fill,
                    height: height * 0.32,
                    width: width * 0.07,
                  ),
                ),
              ],
              // SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
