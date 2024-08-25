import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/pages/Botton_nav_page.dart';
import 'package:mytodoapp/services/data.dart';
import 'package:random_string/random_string.dart';

class Add_page extends StatefulWidget {
  const Add_page({super.key});

  @override
  State<Add_page> createState() => _Add_pageState();
}

class _Add_pageState extends State<Add_page> {
  DateTime? _selectedDate;
  String? _selectedCategory;
  bool _isImportant = false;

  TextEditingController description = TextEditingController();
  TextEditingController time = TextEditingController();

  // Function to display the date picker and format the date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C36CC),
        title: Center(
          child: Text(
            "TODO App",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "Add Description"
              TextField(
                maxLines: 3,
                controller: description,
                decoration: InputDecoration(
                  hintText: "Add Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF0C36CC)),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
              SizedBox(height: 16),

              // "Add Category"
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  hintText: "Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF0C36CC)),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
                items: [
                  DropdownMenuItem(
                    child: Text("Work"),
                    value: "Work",
                  ),
                  DropdownMenuItem(
                    child: Text("Personal"),
                    value: "Personal",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Date Field
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Date",
                  suffix: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF0C36CC)),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
                onTap: () => _selectDate(context),
                controller: TextEditingController(
                  text: _selectedDate == null ? "" : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                ),
              ),
              SizedBox(height: 16),

              // Time Picker Text Field
              TextField(
                controller: time,
                decoration: InputDecoration(
                  hintText: "Time",
                  suffix: Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF000000)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF0C36CC)),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
              SizedBox(height: 16),

              // Important Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Important?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: _isImportant,
                    onChanged: (value) {
                      setState(() {
                        _isImportant = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Done Button
              ElevatedButton(
                onPressed: () async {
                  String id = randomAlpha(10);
                  Map<String, dynamic> taskInfoMap = {
                    "Id": id,
                    "Description": description.text,
                    "Category": _selectedCategory ?? "None",
                    "Date": _selectedDate == null ? "" : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                    "Time": time.text,
                    "IsImportant": _isImportant ? "important" : "Not Important",
                  };
                  print("OK");
                  await DatabaseMethods().addTask(taskInfoMap, id).then((value) {
                    Fluttertoast.showToast(
                      msg: "Task Added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color(0xFF0C36CC),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  });
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Botton_nav()),
                  );
                },
                child: Text(
                  "DONE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Color(0xFF0C36CC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
