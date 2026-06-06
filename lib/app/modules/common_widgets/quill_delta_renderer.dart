import 'dart:convert';
import 'package:flutter/material.dart';
import '../../data/app_text_styles.dart';

class QuillDeltaRenderer extends StatelessWidget {
  final String? deltaString;
  final TextStyle? baseStyle;

  const QuillDeltaRenderer({
    super.key,
    required this.deltaString,
    this.baseStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (deltaString == null || deltaString!.isEmpty) {
      return const SizedBox.shrink();
    }

    try {
      final List<dynamic> delta = jsonDecode(deltaString!);
      final List<_Line> lines = [];
      _Line currentLine = _Line();

      for (var op in delta) {
        if (op is Map && op.containsKey('insert')) {
          final dynamic insert = op['insert'];
          final Map<String, dynamic>? attributes = op['attributes'] != null 
              ? Map<String, dynamic>.from(op['attributes']) 
              : null;

          if (insert is String) {
            final List<String> parts = insert.split('\n');
            for (int i = 0; i < parts.length; i++) {
              if (parts[i].isNotEmpty) {
                currentLine.segments.add(_Segment(parts[i], attributes));
              }
              
              // If it's not the last part, it means there was a \n
              if (i < parts.length - 1) {
                // The attributes on the segment containing \n (or the \n itself) 
                // are block attributes for the line ending here.
                currentLine.blockAttributes = attributes;
                lines.add(currentLine);
                currentLine = _Line();
              }
            }
          }
          // Handle non-string inserts (like images) if needed in future
        }
      }
      
      // Add last line if not empty
      if (currentLine.segments.isNotEmpty || currentLine.blockAttributes != null) {
        lines.add(currentLine);
      }

      final List<Widget> widgets = [];
      int orderedListCounter = 0;

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        final blockAttrs = line.blockAttributes;
        
        // Reset or increment ordered list counter
        if (blockAttrs != null && blockAttrs['list'] == 'ordered') {
          orderedListCounter++;
        } else {
          orderedListCounter = 0;
        }

        widgets.add(_buildLineWidget(line, orderedListCounter));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      );
    } catch (e) {
      return Text(deltaString!, style: baseStyle ?? AppTextStyles.regular14);
    }
  }

  Widget _buildLineWidget(_Line line, int orderedCounter) {
    final blockAttrs = line.blockAttributes;
    Widget content;

    final List<TextSpan> spans = line.segments.map((seg) {
      TextStyle style = baseStyle ?? AppTextStyles.regular14;
      final attrs = seg.attributes;
      if (attrs != null) {
        if (attrs['bold'] == true) {
          style = style.copyWith(fontWeight: FontWeight.bold);
        }
        if (attrs['italic'] == true) {
          style = style.copyWith(fontStyle: FontStyle.italic);
        }
        if (attrs['underline'] == true) {
          style = style.copyWith(decoration: TextDecoration.underline);
        }
        if (attrs['size'] == 'large') {
          style = style.copyWith(fontSize: style.fontSize! * 1.5);
        } else if (attrs['size'] == 'huge') {
          style = style.copyWith(fontSize: style.fontSize! * 2.0);
        } else if (attrs['size'] == 'small') {
          style = style.copyWith(fontSize: style.fontSize! * 0.8);
        }
      }
      return TextSpan(text: seg.text, style: style);
    }).toList();

    content = RichText(
      text: TextSpan(children: spans),
    );

    // Apply header styles to the whole line
    if (blockAttrs != null && blockAttrs.containsKey('header')) {
      final int level = blockAttrs['header'];
      double fontSizeFactor = 1.0;
      if (level == 1) {
        fontSizeFactor = 2.0;
      } else if (level == 2) {
        fontSizeFactor = 1.6;
      } else if (level == 3) {
        fontSizeFactor = 1.4;
      }

      content = DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: (baseStyle?.fontSize ?? 14) * fontSizeFactor,
          fontWeight: FontWeight.bold,
        ),
        child: content,
      );
    }

    // Wrap in list item layout if needed
    if (blockAttrs != null && blockAttrs.containsKey('list')) {
      String prefix = "";
      if (blockAttrs['list'] == 'bullet') {
        prefix = "• ";
      } else if (blockAttrs['list'] == 'ordered') {
        prefix = "$orderedCounter. ";
      }

      return Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
              child: Text(prefix, style: baseStyle ?? AppTextStyles.regular14),
            ),
            Expanded(child: content),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: content,
    );
  }
}

class _Line {
  final List<_Segment> segments = [];
  Map<String, dynamic>? blockAttributes;
}

class _Segment {
  final String text;
  final Map<String, dynamic>? attributes;
  _Segment(this.text, this.attributes);
}
