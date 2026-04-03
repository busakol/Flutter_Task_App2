//ไฟล์ที่ใช้ทำงานต่างๆกับ Supabase
//กรณี table เช่นCRUD ( Ceate, Read, Update, Delete) หรือการเชื่อมต่อกับฐานข้อมูล
//กรณี backend เช่นUpload Delete GetUrl
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_task_app/models/task.dart';
import 'package:flutter/material.dart';

class SupabaseService {
  //สร้าง instance/object/ตัวแทน ของ supabvase_flutter เพื่อจะทำงานต่างๆกับ Supabase
  final supabase = Supabase.instance.client;

  //(มีเยอะหน่อย) method การทำงานต่างๆกับ Supabase
  //Method ดึงข้อมูลงานทั้งหมด จากตาราง task_tb เพื่อไปใช้กับหน้า ShowAllTaskUi
  Future<List<Task>> getAllTask() async {
    //ดึงข้อมูล
    final data = await supabase.from('task_tb').select('*');

    //ส่งค่าข้อมูลที่ดึงกลับไปใช้งานอย่างที่ต้องการ
    return data.map((e) => Task.fromJson(e)).toList();
  }

  //Method Upload ไฟล์รูปภาพไปยังบักเก็ตของ task_tb และ GetUrlของไฟล์รูป เพื่อใช้กับหน้า AddTaskUi และ UpdateDeleteTaskUi
  Future<String?> uploadFiletobucket(File file) async {
    //ตั้งชื่อไฟล์ใหม่เพื่อไม่ให้ซ้ำก่อนอัพโหลด
    final newFileName = '${DateTime.now()}_${file.path.split('/').last}';

    //อัพโหลดไฟล์ไปยังบักเก็ต
    await supabase.storage.from('task_bk').upload(newFileName, file);

    //ส่งค่าข้อมูล URL ชองไฟล์ที่อัพโหลดไปใช้งานอย่างที่ต้องการ
    return supabase.storage.from('task_bk').getPublicUrl(newFileName);
  }

  //Merhod เพิ่ม ข้อมูลในตาราง task_tb เพื่อไปใช้กับหน้า AddTask_tb
  Future<void> insertTask(Task task) async {
    await supabase.from('task_tb').insert(task.toJson());
  }

  //Method ลบ ไฟล์รูปออกจากบักเก็ต task_tb และ UpdateDeleteTaskUi
  Future<void> deleteFileFromBucket(String task_imag_url) async {
    //การลบจะตัดเอาเฉพาะชื่อ
    final fileName = task_imag_url.split('/').last;
    await supabase.storage.from('task_bk').remove([fileName]);
  }

  //Method แก้ไข ข้อมูลในตาราง task_tb เพื่อไปใช้กับหน้า UpdateDeleteTaskUi
  Future<void> updateTask(String id, Task task) async {
    await supabase.from('task_tb').update(task.toJson()).eq('id', id);
  }

  //Method ลบ ข้อมูลออกจากตาราง task_tb เพื่อไปใช้กับหน้า UpdateDeleteTaskUi
  Future<void> deleteTask(String id) async {
    await supabase.from('task_tb').delete().eq('id', id);
  }
}
