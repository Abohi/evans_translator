import 'package:flutter/material.dart';

import '../widgets/choose-language.dart';
import '../widgets/translate-text.dart';
import '../widgets/translate-input.dart';
import '../models/language.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isTextTouched = false;
  Language _firstLanguage = Language('en', 'English');
  Language _secondLanguage = Language('fr', 'French');
  FocusNode _textFocusNode = FocusNode();
  AnimationController _controller;
  Animation _animation;
  String translatedT;
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        this.setState(() {});
      });
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._textFocusNode.dispose();
    super.dispose();
  }

  _onLanguageChanged(Language firstCode, Language secondCode) {
    this.setState(() {
      this._firstLanguage = firstCode;
      this._secondLanguage = secondCode;
    });
  }

 _getTranslatedText(String translatedText){
   this.setState((){
     this.translatedT = translatedText;
   });
   
 }
  // Generate animations to enter the text to translate
  _onTextTouched(bool isTouched) {
    Tween _tween = SizeTween(
      begin: Size(0.0, kToolbarHeight),
      end: Size(0.0, 0.0),
    );

    this._animation = _tween.animate(this._controller);

    if (isTouched) {
      FocusScope.of(context).requestFocus(this._textFocusNode);
      this._controller.forward();
    } else {
      FocusScope.of(context).requestFocus(new FocusNode());
      this._controller.reverse();
    }

    this.setState(() {
      this._isTextTouched = isTouched;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(this._isTextTouched
            ? this._animation.value.height
            : kToolbarHeight),
        child: AppBar(
          title: Text(widget.title),
          elevation: 0.0,
        ),
      ),
      
      body: Column(
        children: <Widget>[
          ChooseLanguage(
            onLanguageChanged: this._onLanguageChanged,
          ),
          Stack(
            children: <Widget>[
              Offstage(
                offstage: this._isTextTouched,
                child: TranslateText(
                  onTextTouched: this._onTextTouched,
                  translatedText: this.translatedT,
                ),
              ),//kkk
              
              Offstage(
                offstage: !this._isTextTouched,
                child: TranslateInput(
                  onCloseClicked: this._onTextTouched,
                  focusNode: this._textFocusNode,
                  firstLanguage: this._firstLanguage,
                  secondLanguage: this._secondLanguage,
                  getTranslatedText: this._getTranslatedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
