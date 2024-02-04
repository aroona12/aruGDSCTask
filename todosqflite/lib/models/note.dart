class Note{
  int? id;
 String? title;
 DateTime? date;
 int? status;
 Note({
   this.title, this.date,this.status
});
 Note.withId({
   this.title, this.date,this.status,this.id
 });
 Map<String, dynamic> toMap(){
   final map = Map<String ,dynamic>();
   if(id!=null){
     map['id']=id;
   }
   map['title'] = title;
   map['date'] = date!.toIso8601String();
   map['status'] =status;
   return map;
 }
 factory Note.fromMap(Map<String, dynamic> map){
   return Note.withId(
     id: map['id'],
     title: map['title'],
       date: DateTime.parse(map['date']),
       status: map['status'],
   );
 }

}