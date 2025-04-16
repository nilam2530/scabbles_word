import 'package:flutter/material.dart';

class OverlayDemo extends StatefulWidget {
  const OverlayDemo({super.key});

  @override
  State<OverlayDemo> createState() => _OverlayDemoState();
}

class _OverlayDemoState extends State<OverlayDemo> {
  OverlayEntry? _overlayEntry;
  String textvalue = 'overlay';
  void _showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 100, // Position relative to the screen
            left: 50,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffFFFDD0),
                  borderRadius: BorderRadius.circular(8),
                  // border: Border.all(),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // log('message');
                        setState(() {
                          textvalue = 'change';
                        });
                        _removeOverlay();
                      },
                      child: Text('A'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // log('message');
                        setState(() {
                          textvalue = 'change';
                        });
                        _removeOverlay();
                      },
                      child: Text('A'),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    overlayState.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Overlay Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showOverlay(context);
            // Future.delayed(
            //   Duration(seconds: 2),
            //   _removeOverlay,
            // ); // Auto-remove after 2 seconds
          },
          child: Text(textvalue),
        ),
      ),
    );
  }
}
