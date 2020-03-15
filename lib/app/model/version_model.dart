class VersionModel{
  String version;
  bool mandatory;
  List<String> updateContent;
  String iosAddress;
  String androidAddress;
  VersionModel.fromJson(Map json){
    version=json['version'];
    mandatory=json['mandatory'];
    updateContent=List.from(json['updateContent']);
    iosAddress=json['iosAddress'];
    androidAddress=json['androidAddress'];
  }

}