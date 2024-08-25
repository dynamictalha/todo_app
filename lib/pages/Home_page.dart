import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/services/data.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
 DateTime? _selectedDate;
  String? _selectedCategory;
  bool? _isImportant;

  TextEditingController description = TextEditingController();
  TextEditingController time = TextEditingController();
   TextEditingController dateController = TextEditingController();
  

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
        dateController.text = DateFormat("dd-MM-yyyy").format(_selectedDate!);
      });

    }
  }
// properties

Stream? taskStream;

getontheload() async{
  taskStream = await DatabaseMethods().getTaskDetails();
  // setState((){}); is called after getontoload to notify
  // the flutter framwork that the state of the widget has change
  // This triggers a rebuild of the widget's UI, ensuring that any changes
  // to the retriveed data are reflected in UI
  setState(() {});
}

// In summary, initState() is being use to initialize the widget and
// kick off the process of fecting Task detail,
// white setState() is use later to update the UI with the fetched data once it's available.
@override
  void initState(){
  getontheload();
  super.initState();

}

// Method for fetching data

Widget allTaskDetails(){
  return StreamBuilder(
    stream: taskStream , 
    builder: (context,AsyncSnapshot snapshot){
      return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(ds["Description"],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,

                                ),),
                                 // for update and delete
                                 Spacer(),
                                 SizedBox(width: 40,),
                                 ElevatedButton(
                                  onPressed: (){
                                    description.text = ds["Description"];
                                    _selectedCategory = ds["Category"];
                                    dateController.text = ds["Date"];
                                    time.text = ds["Time"];
                                    _isImportant = ds["IsImportant"] == "important" ? true : false;
                                    EditTaskDetails(ds["Id"]);
                                    
                                  }, 
                                  child: Icon(Icons.edit,
                                  color: Color(0xFF0C36CC) ,)),
                                  SizedBox(width: 5,),

                                  ElevatedButton(onPressed: () async{
                                    await DatabaseMethods()
                                    .deleteTask(ds["Id"]);
                                  }, 
                                  child:Icon(Icons.delete,
                                  color: Color(0xFF000000) ,))
                              ],
                            ),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(ds["Date"] + " at ",
                                style: TextStyle(
                                  color: Colors.grey
                                ),),
                                Text(ds["Time"],
                                style: TextStyle(
                                  color: Colors.grey
                                ),),
                              ],
                            ),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(ds["Category"],
                                style: TextStyle(
                                  color: Color(0xFF0C36CC),
                                  fontWeight: FontWeight.w600,
                                ),),
                                SizedBox(width: 10,),
                                Text(ds["IsImportant"],
                                style: TextStyle(
                                   color: Colors.red,
                                  fontWeight: FontWeight.w800,
                                ),),
                              ],
                            ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ): Container();
    }
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Decument contain
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          children: [
            Expanded(child: allTaskDetails()),
          ],
        ),
      ),
    );
  }


  Future EditTaskDetails(String id) => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      content: Container(
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Icon(Icons.cancel)),
                SizedBox(width: 40,),
                Text("Edite ",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                 fontWeight: FontWeight.bold,
                ),
                ),
                Text("Tasks",
                style: TextStyle(
                  color: Color(0xFF0C36CC),
                  fontSize: 20,
                 fontWeight: FontWeight.bold,
                ),
                ),
                 
              ],
              
            ),
            SizedBox(height: 10,),
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
              SizedBox(height: 10),

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
              SizedBox(height: 10),

              // Date Field
              TextField(
                readOnly: true,
                controller: dateController,
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
                
              ),
              SizedBox(height: 10),

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
              SizedBox(height: 10),

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
                onPressed: () async{
                  Map<String,dynamic> updateTaskinfo = {
                    "Description": description.text,
                    "Category": _selectedCategory ?? "None",
                    "Date": _selectedDate == null ? "" : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                    "Time": time.text,
                    "IsImportant":_isImportant! ? "important" : "Not Important",
                    "Id": id,
                  };
                  await DatabaseMethods()
                    .updateTask(id, updateTaskinfo)
                    .then((value){
                      Navigator.pop(context);
                    });
                },
                child: Text(
                  "Update",
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
    ));
}