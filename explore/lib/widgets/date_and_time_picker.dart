import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => (runApp(MyDateAndTimePickerApp()));

class MyDateAndTimePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('My Date and Time Picker'),
            ),
            body: MyDateAndTimePickerPage()));
  }
}

class MyDateAndTimePickerPage extends StatefulWidget {
  @override
  State createState() {
    return MyDateAndTimePickerPageState(
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
      selectDate: (date) {
        print(date);
      },
      selectTime: (time) {
        print(time);
      },
    );
  }
}

class MyDateAndTimePickerPageState extends State<MyDateAndTimePickerPage> {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  MyDateAndTimePickerPageState(
      {Key key,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime});

  @override
  Widget build(BuildContext context) {
    return MyDateAndTimePicker(
      selectedDate: this.selectedDate,
      selectedTime: this.selectedTime,
      selectDate: this.selectDate,
      selectTime: this.selectTime,
    );
  }
}

class _InputDropDown extends StatelessWidget {
  const _InputDropDown(
      {Key key,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed,
      this.child});

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(labelText: labelText),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              valueText,
              style: valueStyle,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.shade700,
            )
          ],
        ),
      ),
    );
  }
}

class MyDateAndTimePicker extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  MyDateAndTimePicker(
      {Key key,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      selectDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != selectedTime) {
      selectTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Column(
      children: <Widget>[
        _InputDropDown(
          labelText: 'My Date',
          valueText: DateFormat.yMMMd().format(selectedDate),
          valueStyle: valueStyle,
          onPressed: () {
            _selectDate(context);
          },
        ),
        _InputDropDown(
          labelText: 'My Time',
          valueText: selectedTime.format(context),
          valueStyle: valueStyle,
          onPressed: () {
            _selectTime(context);
          },
        )
      ],
    );
  }
}
