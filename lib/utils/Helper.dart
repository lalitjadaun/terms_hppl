import 'package:terms_hppl/utils/pref.dart';

class Helper{

  //userName
  static void setuserName(String userName){
    SharedPreferencesManager.setString("userName", userName);
  }

  static String getuserName(){
    String userName = SharedPreferencesManager.getString("userName");
    if (userName.length == 0 || userName == "null") {
      return '';
    }else return userName;
  }


  //Employee Code
  static void setemp_cd(String emp_cd){
    SharedPreferencesManager.setString("emp_cd", emp_cd);
  }

  static String getemp_cd(){
    String emp_cd = SharedPreferencesManager.getString("emp_cd");
    if (emp_cd.length == 0 || emp_cd == "null") {
      return '';
    }else return emp_cd;
  }

  //Unit Code

  static void setunit_cd(String unit_cd){
    SharedPreferencesManager.setString("unit_cd", unit_cd);
  }

  static String getunit_cd(){
    String unit_cd = SharedPreferencesManager.getString("unit_cd");
    if (unit_cd.length == 0 || unit_cd == "null") {
      return '';
    }else return unit_cd;
  }

  //AMD_No
  static void setamd_no(int amd_no){
    SharedPreferencesManager.setInt("amd_no", amd_no);
  }


  static int getamd_no(){
    int amd_no = SharedPreferencesManager.getInt("amd_no");
    if (amd_no == 0 || amd_no == "null") {
      return 0;
    }else return amd_no;
  }


  //doc_type
  static void setdoc_type(String doc_type){
    SharedPreferencesManager.setString("doc_type", doc_type);
  }

  static String getdoc_type(){
    String doc_type = SharedPreferencesManager.getString("doc_type");
    if (doc_type.length == 0 || doc_type == "null") {
      return '';
    }else return doc_type;
  }


  //doc_number
 static void setdoc_number(String doc_number){
    SharedPreferencesManager.setString("doc_number", doc_number);
  }

  static String getdoc_number(){
    String doc_number = SharedPreferencesManager.getString("doc_number");
    if (doc_number.length == 0 || doc_number == "null") {
      return '';
    }else return doc_number;
  }

  //name
 static void setname(String name){
    SharedPreferencesManager.setString("name", name);
  }

  static String getname(){
    String name = SharedPreferencesManager.getString("name");
    if (name.length == 0 || name == "null") {
      return '';
    }else return name;
  }

  //doc name

  static void setdoc_name(String doc_name){
    SharedPreferencesManager.setString("doc_name", doc_name);
  }

  static String getdoc_name(){
    String doc_name = SharedPreferencesManager.getString("doc_name");
    if (doc_name.length == 0 || doc_name == "null") {
      return '';
    }else return doc_name;
  }

  //appDt

  static void setappDt(String appDt){
    SharedPreferencesManager.setString("appDt", appDt);
  }

  static String getappDt(){
    String appDt = SharedPreferencesManager.getString("appDt");
    if (appDt.length == 0 || appDt == "null") {
      return '';
    }else return appDt;
  }

  //appStage

  static void setappStage(String appStage){
    SharedPreferencesManager.setString("appStage", appStage);
  }

  static String getappStage(){
    String appStage = SharedPreferencesManager.getString("appStage");
    if (appStage.length == 0 || appStage == "null") {
      return '';
    }else return appStage;
  }

//stock graph item
  static void setitem(String item){
    SharedPreferencesManager.setString("item", item);
  }

  static String getitem() {
    String item = SharedPreferencesManager.getString("item");
    if (item.isEmpty || item == "null") {
      return '';
    } else
      return item;
  }


    //stockgraph closeStock

  static void setcloseStock(String closeStock){
    SharedPreferencesManager.setString("closeStock", closeStock);
  }

  static String getcloseStock(){
    String closeStock = SharedPreferencesManager.getString("closeStock");
    if (closeStock.isEmpty || closeStock == "null") {
      return '';
    }else return closeStock;
  }

//UserID
  static void setuserId(String userId){
    SharedPreferencesManager.setString("userId", userId);
  }

  static String getuserId(){
    String userId = SharedPreferencesManager.getString("userId");
    if (userId.isEmpty || userId == "null") {
      return '';
    }else return userId;
  }


//Unit Name
  static void setunitName(String unitName){
    SharedPreferencesManager.setString("unitName", unitName);
  }

  static String getunitName(){
    String unitName = SharedPreferencesManager.getString("unitName");
    if (unitName.isEmpty || unitName == "null") {
      return '';
    }else return unitName;
  }


}