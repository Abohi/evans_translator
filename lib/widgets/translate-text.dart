import 'package:flutter/material.dart';

class TranslateText extends StatefulWidget {
  TranslateText({Key key, this.onTextTouched, this.translatedText}) : super(key: key);

  final Function(bool) onTextTouched;
  final String translatedText;

  @override
  _TranslateTextState createState() => _TranslateTextState();
}



class _TranslateTextState extends State<TranslateText> {


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0.0),
      elevation: 2.0,
      child: Container(
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  this.widget.onTextTouched(true);
                },
                child: Container(
                  width: double.infinity,
                  padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    "Enter text",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
           Expanded(
             child: Container(
               padding: EdgeInsets.only(left:16.0,right:16.0,top:10.0),
               child: Text(widget.translatedText??"Result here",style:TextStyle(fontSize: 15.0,color: Colors.blue[700])
            )
           )
           )
          ],
        ),
      ),
    );
  }
}
