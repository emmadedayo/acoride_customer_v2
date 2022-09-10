import 'package:flutter/material.dart';

class MapMarker extends StatefulWidget {
  final String location;
  const MapMarker(Key? key, this.location): super(key: key);

  @override
  MapMarkerState createState() => MapMarkerState();
}

class MapMarkerState extends State<MapMarker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 40.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: Text(
                  widget.location,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
              height: 10.0,
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14)))),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 36.0,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 3, 0.0);
    path.lineTo(size.width / 2, size.height / 3);
    path.lineTo(size.width - size.width / 3, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}