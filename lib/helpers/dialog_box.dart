import 'package:flutter/material.dart';


//Showing popup message or directions to the users
class AppDialog extends StatefulWidget {
  String header;
  String description;
  String? move;
  Map? args;
  String? popUntil;


  AppDialog(
      {Key? key,
        required this.header,
        required this.description,
        this.move,
        this.args,
        this.popUntil,
      })
      : super(key: key);

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  Stack contentBox(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
          const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.header,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width*0.5,
                child:  TextButton(
                    style:  TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shadowColor: Colors.grey,
                      elevation: 3,
                    ),
                    onPressed:(){
                      Navigator.of(context).pop();

                    },
                    child:Text('Okay',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),)),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  void handleStack(String route, Map? args) {
    Navigator.pop(context, true);
    Navigator.pushNamed(context, route, arguments: args);
  }
}
