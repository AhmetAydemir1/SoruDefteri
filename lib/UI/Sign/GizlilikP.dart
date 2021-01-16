import 'package:flutter/material.dart';

class GizlilikP extends StatefulWidget {
  @override
  _GizlilikPState createState() => _GizlilikPState();
}

class _GizlilikPState extends State<GizlilikP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6E719B),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          "Gizlilik Politikası",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Text(
                  "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. ",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0),
            child: Container(
              height: 45.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      color: Color(0xFF00AE87),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.5,
                        minHeight: 45.0),
                    alignment: Alignment.center,
                    child: Text(
                      "KABUL ET VE DEVAM ET",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
