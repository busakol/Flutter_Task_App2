//ไฟล์ที่แมปกับข้อมูลในตารางบน Supabase
class Task {
  //ตัวแปรที่ล้อกับชื่อคอลัมน์ในตาราง
  String? id;
  String? task_name;
  String? task_where;
  int? task_person;
  bool? task_status;
  String? task_duedate;
  String? task_images_url;

  // Constructor
  //ที่เอาไว้แพ็กข้อมูลเวลาส่งไป Insert/Update ไปยัง Supabase
  //ที่เอาไว้แพ็กข้อมูลเวลาส่งค่าระหว่างหน้าจอ หรือ ส่งค่าข้อมูลไปมาใดๆ
Task({
    this.id,
    this.task_name,
    this.task_where,
    this.task_person,
    this.task_status,
    this.task_duedate,
    this.task_images_url,
  });

  // คำสั่งในการแปลงข้อมูลจาก Supabase ซึ่งเป็น JSOM มาใช้ในแอปฯ formJson
factory Task.fromJson(Map<String, dynamic> json) => Task (
      id: json['id'],
      task_name: json['task_name'],
      task_where: json['task_where'],
      task_person: json['task_person'],
      task_status: json['task_status'],
      task_duedate: json['task_duedate'],
      task_images_url: json['task_images_url'],
    );
    
  // คำสั่งในการแปลงข้อมูลจาก แอปฯ ไปเป็น JSON เพื่อส่งไปยัง Supabase -> toJson
Map<String, dynamic> toJson() => {
    'id': id,
    'task_name': task_name,
    'task_where': task_where,
    'task_person': task_person,
    'task_status': task_status,
    'task_duedate': task_duedate,
    'task_images_url': task_images_url,
  };



}