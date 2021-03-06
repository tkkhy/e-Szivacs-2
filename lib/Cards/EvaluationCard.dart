import 'dart:async';

import 'package:flutter/material.dart';

import '../Datas/Evaluation.dart';
import '../Helpers/SettingsHelper.dart';
import '../Utils/StringFormatter.dart';
import '../globals.dart' as globals;

class EvaluationCard extends StatelessWidget {
  Evaluation evaluation;
  Color bColor;
  Color fColor;

  IconData typeIcon;
  String typeName;
  bool showPadding;
  bool isSingle;

  BuildContext context;

  String textShort;

  Future<bool> get isColor async {
    return await SettingsHelper().getColoredMainPage();
  }

  EvaluationCard(Evaluation evaluation, bool isColor, bool isSingle,
      BuildContext context) {
    this.evaluation = evaluation;
    this.context = context;

    bool hastype = true;
    this.isSingle = isSingle;

    if (isColor) {
      switch (evaluation.numericValue) {
        case 0:
          break;
        case 1:
          bColor = Colors.red;
          fColor = Colors.white;
          break;
        case 2:
          bColor = Colors.brown;
          fColor = Colors.white;
          break;
        case 3:
          bColor = Colors.orange;
          fColor = Colors.white;
          break;
        case 4:
          bColor = Color.fromARGB(255, 255, 241,
              118); //rgb(255,235,59)rgb(253, 216, 53)rgb(192, 202, 51)rgb(255,241,118)rgb(255,234,0)rgb(255,255,0)
          fColor = Colors.black;
          break;
        case 5:
          bColor = Colors.green; //dce775
          fColor = Colors.white;
          break;
        default:
          bColor = Colors.black;
          fColor = Colors.white;
          break;
      }
    }

    switch (evaluation.mode) {
      case "Írásbeli témazáró dolgozat":
        typeIcon = Icons.widgets;
        typeName = "TZ";
        break;
      case "Témazáró":
        typeIcon = Icons.widgets;
        typeName = "témazáró";
        break;
      case "Írásbeli röpdolgozat":
        typeIcon = Icons.border_color;
        typeName = "röpdolgozat";
        break;
      case "Dolgozat":
        typeIcon = Icons.subject;
        typeName = "dolgozat";
        break;
      case "Projektmunka":
        typeIcon = Icons.assignment;
        typeName = "projektmunka";
        break;
      case "Gyakorlati feladat":
        typeIcon = Icons.directions_walk;
        typeName = "gyakorlati feladat";
        break;
      case "Szódolgozat":
        typeIcon = Icons.language;
        typeName = "szódolgozat";
        break;
      case "Szóbeli felelet":
        typeIcon = Icons.person;
        typeName = "felelés";
        break;
      case "Házi feladat":
        typeIcon = Icons.home;
        typeName = "házi feladat";
        break;
      case "Órai munka":
        typeIcon = Icons.school;
        typeName = "órai munka";
        break;
      case "Versenyen, vetélkedőn való részvétel":
        typeIcon = Icons.account_balance;
        typeName = "verseny";
        break;
      case "Magyar nyelv évfolyamdolgozat":
        typeIcon = Icons.book;
        typeName = "évfolyamdolgozat";
        break;
      case "":
        typeIcon = null;
        typeName = "";
        hastype = false;
        break;
      case "Na":
        typeIcon = null;
        typeName = "";
        hastype = false;
        break;
      default:
        typeIcon = Icons.help;
        typeName = evaluation.mode;
        break;
    }

    showPadding = !isSingle || hastype;
  }

  String getDate() {
    return evaluation.creationDate.toIso8601String();
  }

  @override
  Key get key => new Key(getDate());

  void openDialog() {
    _evaluationDialog(evaluation);
  }

  Widget listEntry(String data, {bold = false, right = false}) => new Container(
    child: new Text(
      data,
      style: TextStyle(fontSize: right ? 16 : 19, fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    ),
    alignment: right ? Alignment(1, -1) : Alignment(0, 0),
    padding: EdgeInsets.only(bottom: 3),
  );

  Future<Null> _evaluationDialog(Evaluation evaluation) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return new SimpleDialog(
          children: <Widget>[
            new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  evaluation.value != null
                      ? listEntry(evaluation.value)
                      : new Container(),
                  evaluation.weight != "" &&
                          evaluation.weight != "100%" &&
                          evaluation.weight != null
                      ? listEntry(evaluation.weight, bold: ["200%", "300%"].contains(evaluation.weight))
                      : new Container(),
                  evaluation.theme != "" && evaluation.theme != null
                      ? listEntry(evaluation.theme)
                      : new Container(),
                  evaluation.mode != "" && evaluation.mode != null
                      ? listEntry(evaluation.mode)
                      : new Container(),
                  evaluation.creationDate != null
                      ? listEntry(dateToHuman(evaluation.creationDate), right: true)
                      : new Container(),
                  evaluation.teacher != null
                      ? listEntry(evaluation.teacher, right: true)
                      : new Container(),
                ],
              ),
            ),
          ],
          title: (evaluation.subject != null)
              ? Text(evaluation.subject)
              : new Container(),
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              style: BorderStyle.none,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (evaluation.value) {
      case "Példás":
        textShort = ":D";
        bColor = Colors.green; //dce775
        fColor = Colors.white;
        break;
      case "Jó":
        textShort = ":)";
        bColor = Color.fromARGB(255, 255, 241, 118); //dce775
        fColor = Colors.black;
        break;
      case "Változó":
        textShort = ":/";
        bColor = Colors.brown; //dce775
        fColor = Colors.white;
        break;
      case "Hanyag":
        textShort = ":(";
        bColor = Colors.red; //dce775
        fColor = Colors.white;
        break;
    }

    return new GestureDetector(
      onTap: openDialog,
      child: new Card(
        color: bColor,
        child: new Column(
          children: <Widget>[
            new Container(
              child: new ListTile(
                title: evaluation.subject != null
                    ? new Text(evaluation.subject,
                        style: new TextStyle(
                            color: fColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold))
                    : new Container(),
                leading: (evaluation.numericValue != 0 && textShort == null)
                    ? new Text(evaluation.numericValue.toString(),
                        style: new TextStyle(
                            color: fColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold))
                    : new Text(textShort ?? "",
                        style: new TextStyle(
                            color: fColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)),
                subtitle: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    evaluation.isText()
                        ? new Text(evaluation.value)
                        : new Container(),
                    evaluation.theme != null
                        ? new Text(evaluation.theme,
                            style: new TextStyle(color: fColor, fontSize: 18.0))
                        : Container(),
                    new Text(
                      evaluation.teacher,
                      style: new TextStyle(color: fColor, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            !showPadding || !isSingle
                ? new Container(
                    child: new Text(
                        dateToHuman(evaluation.date) +
                            dateToWeekDay(evaluation.date),
                        style: new TextStyle(fontSize: 16.0, color: fColor)),
                    alignment: Alignment(1.0, -1.0),
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 2.0),
                  )
                : new Container(),
            showPadding
                ? new Container(
                    color: globals.isDark
                        ? Color.fromARGB(255, 25, 25, 25)
                        : Colors.white,
                    child: new Padding(
                      padding: new EdgeInsets.all(7.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Divider(),
                          new Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: new Icon(typeIcon,
                                color: globals.isDark
                                    ? Colors.white
                                    : Colors.black87),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: typeName != null
                                ? new Text(
                                    typeName,
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        color: globals.isDark
                                            ? Colors.white
                                            : Colors.black87),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                : new Text(
                                    evaluation.value,
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        color: globals.isDark
                                            ? Colors.white
                                            : Colors.black87),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                          ),
                          new Flexible(
                            child: new Container(
                              child: new Padding(
                                child: evaluation.weight != "100%"
                                    ? new Text(evaluation.weight,
                                        style: TextStyle(
                                            color: globals.isDark
                                                ? Colors.white
                                                : Colors.black87))
                                    : null,
                                padding: new EdgeInsets.all(7.0),
                              ),
                              alignment: Alignment(-1, 0),
                            ),
                          ),
                          !isSingle
                              ? new Expanded(
                                  child: new Container(
                                    child: new Text(evaluation.owner.name,
                                        style: new TextStyle(
                                            color: evaluation.owner.color,
                                            fontSize: 18.0)),
                                    alignment: Alignment(1.0, -1.0),
                                  ),
                                )
                              : new Container(),
                          isSingle
                              ? new Expanded(
                                  child: new Container(
                                    child: new Text(
                                      dateToHuman(evaluation.date) +
                                          dateToWeekDay(evaluation.date),
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          color: globals.isDark
                                              ? Colors.white
                                              : Colors.black87),
                                      textAlign: TextAlign.end,
                                    ),
                                    alignment: Alignment(1.0, 0.0),
                                  ),
                                )
                              : new Container(),
                        ],
                      ),
                    ))
                : new Container()
          ],
        ),
      ),
    );
  }
}
