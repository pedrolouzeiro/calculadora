// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class isDisplay extends StatelessWidget {
  const isDisplay({
    required Key key,
    required this.operation,
  }) : super(key: key);

  final String operation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Stack(
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFbfc0a1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    width: 8,
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4, left: 8),
                    child: AutoSizeText(
                      operation,
                      minFontSize: 20.0,
                      maxFontSize: 80.0,
                      maxLines: 1,
                      style: TextStyle(
                        color: Color(0xFF1f201a),
                        fontSize: 60,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
