import 'package:flutter/material.dart';


//This is to show alert to the users
class AlertBox extends StatefulWidget {
  String header;
  String description;
  String? value;
  String? yes;
  final VoidCallback okay;
  final VoidCallback? cancel;
  Color? okColor;
  Color? cancelColor;

  AlertBox(
      {Key? key,
        required this.header,
        required this.description,
        required this.okay,
        this.cancel,
        this.value,
        this.yes,
        this.okColor,
        this.cancelColor})
      : super(key: key);

  @override
  State<AlertBox> createState() => _AppDialogState();
}

class _AppDialogState extends State<AlertBox> {
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
          const EdgeInsets.only(top: 25, bottom: 25, right: 25, left: 25),
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
                height: 15.0,
              ),
              if (widget.value != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.value!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black),
                  ),
                ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                   TextButton(
                  style:  TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 3,
                  ),
                  onPressed:(){
                    Navigator.of(context).pop();

                  },
                  child:Text('Cancel',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),)),
                  Spacer(),
                  TextButton(
                      style:  TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shadowColor: Colors.grey,
                        elevation: 3,
                      ),
                      onPressed:(){
                        Navigator.of(context).pop();
                        widget.okay();
                      },
                      child:Text(widget.yes!,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20
                        ),)),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }


  //We can handle the stack if we want
  void handleStack(String route) {
    Navigator.pop(context, true);
    Navigator.pushNamed(context, route);
  }
}
