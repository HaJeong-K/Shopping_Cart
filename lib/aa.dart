


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Table extends StatefulWidget {

  @override
  _Tablestate createState() => _Tablestate();

}

class _Tablestate extends State<Table> {

var _selectedDay;
var _focusedDay = DateTime.now();
var _calendarFormat = CalendarFormat.month;


    iTableCalendar(
locale: 'ko_KR',
firstDay: DateTime.now().subtract(Duration(days: 365*10 + 2)),
lastDay: DateTime.now().add(Duration(days: 365*10 + 2)),
focusedDay: _focusedDay,
selectedDayPredicate: (day) {
return isSameDay(_selectedDay, day);
},
onDaySelected: (selectedDay, focusedDay) {
setState(() {
_selectedDay = selectedDay;
_focusedDay = focusedDay;
});
},
onPageChanged: (focusedDay) {
_focusedDay = focusedDay;
},
calendarFormat: _calendarFormat,
onFormatChanged: (format) {
setState(() {
_calendarFormat = format;
});
},
calendarBuilders: CalendarBuilders(
defaultBuilder: (context, dateTime, _) {
return CalendarCellBuilder(context, dateTime, _, 0);
},
todayBuilder: (context, dateTime, _) {
return CalendarCellBuilder(context, dateTime, _, 1);
},
selectedBuilder: (context, dateTime, _) {
return CalendarCellBuilder(context, dateTime, _, 2);
},
),
)

async Widget CalendarCellBuilder(BuildContext context, DateTime dateTime, _, int type){
  /*
    do stuff
    */
  return Container(
    padding: EdgeInsets.all(3),
    child: Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: color,
      ),
      child: Column(
        children: [
          Text(date, style: TextStyle(fontSize: 17),),
          Expanded(child: Text("")),
          Text(moneyString,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: nowIndexColor[900]),),
        ],
      ),
    ),
  );
}
