import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

final format = DateFormat("dd-MM-yyyy HH:mm");

class BasicDateTimeField extends StatelessWidget {
  Widget pick(
      BuildContext context, String title, TextEditingController controllera) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
        controller: controllera,
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            controllera.text = DateFormat('dd/MM/yyyy HH:mm')
                .format(DateTimeField.combine(date, time));
            print(controllera.text + "aaaa");
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[]);
  }
}
