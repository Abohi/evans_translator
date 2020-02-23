import 'dart:io';

import 'package:evans_translator/models/language.dart';
import 'package:evans_translator/widgets/choose-language.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  File pickedImage;
  bool isImageLoaded = false;
  bool isLoading=false;
  Language _firstLanguage = Language('en', 'English');
  Language _secondLanguage = Language('fr', 'French');
  String textTranslated;
  
  _onLanguageChanged(Language firstCode, Language secondCode) {
    this.setState(() {
      this._firstLanguage = firstCode;
      this._secondLanguage = secondCode;
    });
  }


  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

   Future fromCamera() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future<String> readText() async {
    String finalText="";
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        finalText += line.text+"\n";
      }

    }
    return finalText;
  }

  Future translateImage() async{
    this.setState((){
      isLoading = true;
    });
    
   var textFromImage = await readText();
   GoogleTranslator _translator = new GoogleTranslator();

   _translator.translate(textFromImage,from: this._firstLanguage.code,to: this._secondLanguage.code)
   .then((translatedText){
        this.setState(() {
          isLoading = false;
          this.textTranslated = translatedText;
        });
   });

  }

  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      print(readableCode.displayValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Evans Translator"),
        ),
        body: Column(
      children: <Widget>[
        isImageLoaded
            ? Expanded(
                      flex: 1,
                      child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                         border: Border(
                            bottom: BorderSide(
                              width: 0.10,
                              color: Colors.grey[500],
                            ),
                          ),
                          image: DecorationImage(
                              image: FileImage(pickedImage), fit: BoxFit.cover)
                              )
                      ),
                )
            : Expanded(
                      flex: 1,
                      child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                         border: Border(
                            bottom: BorderSide(
                              width: 0.10,
                              color: Colors.grey[500],
                            ),
                          ),
                          color: Colors.pinkAccent
                        ),
                        child: Align(
                            alignment:Alignment.center,
                            child: Center(
                            child: Text("Use one of the given buttons to provide an Image")
                          ),
                        ),
                    )
                ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
                         border: Border(
                            bottom: BorderSide(
                              width: 0.10,
                              color: Colors.grey[500],
                            ),
                          )
                        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               RaisedButton(
                child: Text('Gallary'),
                onPressed: pickImage,
            ),
             RaisedButton(
            child: Text('Camera'),
            onPressed: fromCamera,
        ),
            ],
          )   
        ),
        SizedBox(height: 10.0),
        Text("Choose Langauges"),
        SizedBox(height: 10.0),
        ChooseLanguage(
            onLanguageChanged: this._onLanguageChanged,
          ),
        SizedBox(height: 10.0),
        RaisedButton(
            child: Text('Translate'),
            onPressed: translateImage,
        ),
        SizedBox(height: 10.0),
        isLoading?CircularProgressIndicator():Expanded(
                      child: Container(
                      width: double.infinity,  
                      height: 50.0,
                      decoration: BoxDecoration(
                         border: Border(
                            bottom: BorderSide(
                              width: 0.10,
                              color: Colors.grey[500],
                            ),
                          ),
                          color: Colors.pinkAccent
                        ),
                        child:Text(this.textTranslated??"Result here"),
                    )
                )
      ],
    ));
  }
}