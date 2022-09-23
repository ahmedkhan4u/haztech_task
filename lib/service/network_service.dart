import 'package:http/http.dart' as http;

class NetworkHandler{


  static Future<String> getData(String url)async{
   http.Response res  = await http.get(Uri.parse(url));
   if(res.statusCode == 200){
     return res.body;
   }
   return '[]';
  }

}