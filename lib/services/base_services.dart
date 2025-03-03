class BaseServices{
  static const url = 'http://192.168.1.35:8085/api';
  static const headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static getHeaderWithToken(String token){
    return {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json; charset=UTF-8'
    };
  }
}