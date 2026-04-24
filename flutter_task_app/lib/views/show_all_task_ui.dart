import 'package:flutter/material.dart';
import 'package:flutter_task_app/models/task.dart';
import 'package:flutter_task_app/views/add_task_ui.dart';
import 'package:flutter_task_app/services/supabase_service.dart';
import 'package:flutter_task_app/views/update_delete_task_ui.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  //สร้าง instance ของ SupabaseService เพื่อเรียกใช้ฟังก์ชันต่างๆ ที่เกี่ยวข้องกับการดึงข้อมูลจาก Supabase
  final service = SupabaseService();

  //สร้างตัวแปรที่ดึงมาจากข้อมูลที่จะดึงมาจาก Supabase เพื่อแสดงใน Listview
  List<Task> tasks = [];

  //สร้าง method เพื่อดึงข้อมูล แล้วเอาข้อมูลที่ดึงมากำหนดให้กับตัวแปร
  void loadTask() async {
    //ดึงข้อมูล Supabase
    final data = await service.getAllTask();

    //เอาข้อมูลทรี่ดึงมา กำหนดให้กับตัวแปร
    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    super.initState();
    //เรียกใช้ method loadTask() ให้ทำงาน
    loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          'TASK ME',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // เปิดไปหน้า add task ui แบบย้อนกลับได้
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskUi(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[800],
      ),
      //ตำแหน่งของ Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //ส่วนของ Body
      body: Center(
        child: Column(
          children: [
            //ส่วนของแสดงรูปภาพโลโก้
            SizedBox(height: 50),
            Image.asset(
              'assets/images/logo.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 50),
            //ส่วนของ Listview แสดงรายการข้อมูลงานที่ดึงมาจาก Supabase
            Expanded(
              child: ListView.builder(
                //จำนวนรายการใน Listview
                itemCount: tasks.length,
                //สร้างหน้าตาของแต่ละรายการใน Listview
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 5, bottom: 5),
                    child: ListTile(
                      onTap: () {
                        //เปิดไปหน้า Update Delete Task UI แบบย้แนกลับได้
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDeleteTaskUi(),
                          ),
                        );
                      },
                      title: Text(
                        'งาน: ${tasks[index].task_name}',
                      ),
                      subtitle: Text(
                        // ternary operator ___? ___ : ___
                        'สถานะ: ${tasks[index].task_status == true ? 'เสร็จแล้ว' : 'ยังไม่เสร็จ'}',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: Colors.green,
                      ),
                      leading: tasks[index].task_images_url == ''
                          ? Image.asset(
                              'assets/images/task.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              tasks[index].task_images_url!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                      tileColor:
                          index % 2 == 0 ? Colors.green[200] : Colors.amber[50],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
