import 'package:flutter/material.dart';
import '../models/language.dart';
import '../widgets/language-list-element.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key, this.title})
      : super(key: key);

  final String title;
  

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final TextEditingController _searchTextController = TextEditingController();
  final List<Language> _languageList = [
    Language('af', 'Afrikaans'),
    Language('sq', 'Albanian'),
    Language('am', 'Amharic'),
    Language('ar', 'Arabic'),
    Language('hy', 'Armenian'),
    Language('az', 'Azerbaijani'),
    Language('eu', 'Basque'),
    Language('be', 'Belarusian'),
    Language('bn', 'Bengali'),
    Language('bs', 'Bosnian'),
    Language('bg', 'Bulgarian'),
    Language('ca', 'Catalan'),
    Language('ceb', 'Cebuano'),
    Language('ny', 'Chichewa'),
    Language('zh-cn', 'Chinese Simplified'),
    Language('zh-tw', 'Chinese Traditional'),
    Language('co', 'Corsican'),
    Language('hr', 'Croatian'),
    Language('cs', 'Czech'),
    Language('da', 'Danish'),
    Language('nl', 'Dutch'),
    Language('en', 'English'),
    Language('eo', 'Esperanto'),
    Language('et', 'Estonian'),
    Language('tl', 'Filipino'),
    Language('fi', 'Finnish'),
    Language('fr', 'French'),
    Language('fy', 'Frisian'),
    Language('gl', 'Galician'),
    Language('ka', 'Georgian'),
    Language('de', 'German'),
    Language('el', 'Greek'),
    Language('gu', 'Gujarati'),
    Language('ht', 'Haitian Creole'),
    Language('ha', 'Hausa'),
    Language('haw', 'Hawaiian'),
    Language('iw', 'Hebrew'),
    Language('hi', 'Hindi'),
    Language('hmn', 'Hmong'),
    Language('hu', 'Hungarian'),
    Language('is', 'Icelandic'),
    Language('ig', 'Igbo'),
    Language('id', 'Indonesian'),
    Language('ga', 'Irish'),
    Language('it', 'Italian'),
    Language('ja', 'Japanese'),
    Language('jw', 'Javanese'),
    Language('kn', 'Kannada'),
    Language('kk', 'Kazakh'),
    Language('km', 'Khmer'),
    Language('ko', 'Korean'),
    Language('ku', 'Kurdish (Kurmanji)'),
    Language('ky', 'Kyrgyz'),
    Language('lo', 'Lao'),
    Language('la', 'Latin'),
    Language('lv', 'Latvian'),
    Language('lt', 'Lithuanian'),
    Language('lb', 'Luxembourgish'),
    Language('mk', 'Macedonian'),
    Language('mg', 'Malagasy'),
    Language('ms', 'Malay'),
    Language('ml', 'Malayalam'),
    Language('mt', 'Maltese'),
    Language('mi', 'Maori'),
    Language('mr', 'Marathi'),
    Language('mn', 'Mongolian'),
    Language('my', 'Myanmar (Burmese)'),
    Language('ne', 'Nepali'),
    Language('no', 'Norwegian'),
    Language('ps', 'Pashto'),
    Language('fa', 'Persian'),
    Language('pl', 'Polish'),
    Language('pt', 'Portuguese'),
    Language('ma', 'Punjabi'),
    Language('ro', 'Romanian'),
    Language('ru', 'Russian'),
    Language('sm', 'Samoan'),
    Language('gd', 'Scots Gaelic'),
    Language('sr', 'Serbian'),
    Language('st', 'Sesotho'),
    Language('sn', 'Shona'),
    Language('sd', 'Sindhi'),
    Language('si', 'Sinhala'),
    Language('sk', 'Slovak'),
    Language('sl', 'Slovenian'),
    Language('so', 'Somali'),
    Language('es', 'Spanish'),
    Language('su', 'Sundanese'),
    Language('sw', 'Swahili'),
    Language('sv', 'Swedish'),
    Language('tg', 'Tajik'),
    Language('ta', 'Tamil'),
    Language('te', 'Telugu'),
    Language('th', 'Thai'),
    Language('tr', 'Turkish'),
    Language('uk', 'Ukrainian'),
    Language('ur', 'Urdu'),
    Language('uz', 'Uzbek'),
    Language('vi', 'Vietnamese'),
    Language('cy', 'Welsh'),
    Language('xh', 'Xhosa'),
    Language('yi', 'Yiddish'),
    Language('yo', 'Yoruba'),
    Language('zu', 'Zulu'),
  ];

  @override
  void initState() {
    super.initState();

   
  }

  // Send back the selected language
  _sendBackLanguage(Language language) {
    Navigator.pop(context, language);
  }

  // Display the delete text icon if we typed text in the search input
  Widget _displayDeleteTextIcon() {
    if (this._searchTextController.text.length > 0) {
      return IconButton(
        icon: Icon(Icons.close),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            _searchTextController.text = "";
          });
        },
      );
    } else {
      return null;
    }
  }

  // Display the list with header if we are not searching
  // Display the list with only languages if we are searching
  Widget _displayTheRightList() {
    if (this._searchTextController.text == "") {
      return this._displayList();
    } else {
      return this._displaySearchedList();
    }
  }

  // Display the language list filtered
  Widget _displaySearchedList() {
    List<Language> searchedList = this
        ._languageList
        .where((e) => e.name
            .toLowerCase()
            .contains(this._searchTextController.text.toLowerCase()))
        .toList();

    // Display
    return Expanded(
      child: ListView.builder(
        itemCount: searchedList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return LanguageListElement(
            language: searchedList[index],
            onSelect: this._sendBackLanguage,
          );
        },
      ),
    );
  }

  // Display the list with headers, means we are not searching
  Widget _displayList() {
     return Expanded(
        child: ListView.builder(
        itemCount: this._languageList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return LanguageListElement(
              language: _languageList[index],
              onSelect: this._sendBackLanguage,
            );
        },
      ) 
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
              left: 8.0,
              right: 8.0,
            ),
            child: TextField(
              controller: this._searchTextController,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[600])),
                prefixIcon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Colors.grey,
                ),
                suffixIcon: this._displayDeleteTextIcon(),
              ),
            ),
          ),
          this._displayTheRightList(),
        ],
      ),
    );
  }
}
