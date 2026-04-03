class AdvModel{
  final int id;
  final String title;
  final String description;
  final String image;
  final String createdAt;
  final String updatedAt;
  AdvModel({
   required this.id,
   required this.title,
   required this.description,
   required this.image,
   required this.createdAt,
   required this.updatedAt,
});
  factory AdvModel.fromJson(Map<String,dynamic>json){
    return AdvModel(
        id: json['id'],
        title: json['title']??"",
        description: json['description']??"",
        image: json['image']??"",
        createdAt: json['created_at']??"",
        updatedAt: json['Updated_at']??"",
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'description':description,
      'image':image,
      'created_at':createdAt,
      'Updated_at':updatedAt,
    };
  }
}