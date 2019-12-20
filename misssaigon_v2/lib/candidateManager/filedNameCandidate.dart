import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';

class FieldNameCandidate extends StatelessWidget {
  final TextEditingController namecontroller;
  final labeltext;
  FieldNameCandidate({this.namecontroller, this.labeltext});
  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<CandiState>(context);
    return TextField(
      onChanged: (changed) => appstate.setDisplayText(changed),
      onSubmitted: (submitted) => appstate.setDisplayText(submitted),
      controller: namecontroller,
      style: new TextStyle(fontSize: 18),
      decoration: InputDecoration(
          labelText: labeltext,
          errorText: appstate.isError ? "Field name cannot be blank" : null,
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(color: Color(0xffCED0D2), width: 0),
          //   //  borderRadius: BorderRadius.all(Radius.circular(6))
          // ),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
    );
  }
}
