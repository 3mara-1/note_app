import 'package:flutter/material.dart';
// noteColors
final List<Color> noteColors = [
  const Color(0xFFF28B82), // Red
  const Color(0xFFFBBC04), // Orange
  const Color(0xFFFFF475), // Yellow
  const Color(0xFFCCFF90), // Green
  const Color(0xFFA7FFEB), // Teal
  const Color(0xFFCBF0F8), // Blue
  const Color(0xFFD7AEFB), // Purple
  const Color(0xFFE8EAED), // Gray
];

class ColorPickerBar extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ColorPickerBar({super.key, required this.onColorSelected});

  @override
  State<ColorPickerBar> createState() => _ColorPickerBarState();
}

class _ColorPickerBarState extends State<ColorPickerBar> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // <-- هذا هو السطر الذي يحل المشكلة
      child: ListView.builder(
        // 3. اجعل التمرير أفقيًا
        scrollDirection: Axis.horizontal,
        itemCount: noteColors.length,
        itemBuilder: (context, index) {
          final color = noteColors[index];
          // التحقق إذا كان هذا اللون هو المختار حاليًا
          final isSelected = selectedColor == color;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () {
                // عند الضغط، قم بتحديث اللون المختار
                setState(() {
                  selectedColor = color;
                });
                widget.onColorSelected(color);
              },
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: color,
                  // أضف علامة مميزة للون المختار
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.black)
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
