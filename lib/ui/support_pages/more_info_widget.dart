import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreInfoWidget extends StatefulWidget {
  final String moreText;
  final String title;
  final Stream<bool> stream;

  const MoreInfoWidget({Key key, this.stream, this.moreText, this.title})
      : super(key: key);

  @override
  _MoreInfoWidgetState createState() => _MoreInfoWidgetState();
}

class _MoreInfoWidgetState extends State<MoreInfoWidget> {
  bool _currentValue = false;

  void _updateBool(bool newValue) {
    if (this.mounted) {
      setState(() {
        print(newValue);
        _currentValue = newValue;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((value) {
      _updateBool(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return !_currentValue
        ? Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: Color(0xffD9DBDF),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: w * 0.70,
                  child: Text(
                    widget.title,
                    style: TextStyle(fontFamily: "Root",fontSize: 17, color: Color(0xff15304D)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  child: Icon(
                    Icons.add,
                    color: Color(0xff1262CB),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: Color(0xffD9DBDF),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w * 0.75,
                      child: Text(
                        widget.title,
                        style: TextStyle(fontFamily: "Root",fontSize: 20, color: Color(0xff15304D), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                      child: Icon(
                        Icons.close,
                        color: Color(0xff1262CB),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 4),
                  child:  Text(
                    widget.moreText,
                    style: TextStyle(fontFamily: "Root",fontSize: 15, color: Color(0xff15304D).withOpacity(0.5)),
                  ),
                ),
              ],
            ),
          );
  }
}
