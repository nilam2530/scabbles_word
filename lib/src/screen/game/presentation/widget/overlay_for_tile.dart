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
          },
          child: Text(textvalue),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'overlay_bloc.dart';
// import 'overlay_event.dart';
// import 'overlay_state.dart';

// class OverlayDemo extends StatelessWidget {
//   const OverlayDemo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OverlayBloc(),
//       child: const OverlayView(),
//     );
//   }
// }

// class OverlayView extends StatefulWidget {
//   const OverlayView({super.key});

//   @override
//   State<OverlayView> createState() => _OverlayViewState();
// }

// class _OverlayViewState extends State<OverlayView> {
//   OverlayEntry? _overlayEntry;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     context.read<OverlayBloc>().stream.listen((state) {
//       if (state.isOverlayVisible && _overlayEntry == null) {
//         _showOverlay(context);
//       } else if (!state.isOverlayVisible && _overlayEntry != null) {
//         _removeOverlay();
//       }
//     });
//   }

//   void _showOverlay(BuildContext context) {
//     final bloc = context.read<OverlayBloc>();

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 100,
//         left: 50,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color(0xffFFFDD0),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     bloc.add(ChangeTextValue());
//                   },
//                   child: const Text('A'),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     bloc.add(ChangeTextValue());
//                   },
//                   child: const Text('A'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: BlocBuilder<OverlayBloc, OverlayState>(
//           builder: (context, state) {
//             return ElevatedButton(
//               onPressed: () {
//                 context.read<OverlayBloc>().add(ShowOverlay());
//               },
//               child: Text(state.textValue),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
