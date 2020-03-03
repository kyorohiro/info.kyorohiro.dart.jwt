import 'dart:convert' as conv;


// JWT Token has 3 Parts
class JWTParts {
  List<int> _header;
  List<int> _payload;
  List<int> _signature;
  List<int> get header => _header;
  List<int> get payload => _payload;
  List<int> get signature => _signature; 

  JWTParts.fromToken(String token){
    var parts = token.split('.');
    _header = decodeJWTBase64(parts[0]);
    _payload = decodeJWTBase64(parts[1]);
    _signature = decodeJWTBase64(parts[2]);
  }

  // JWT uses a variant of Base64 encoding that is safe for URLs. 
  // This encoding basicallysubstitutes the “+” and “/” characters for the “-” and “_” characters, 
  // respectively.Padding is removed as well. This variant is known as base64url3.
  // Note that all referencesto Base64 encoding in this document refer to this variant
  // ref https://auth0.com/resources/ebooks/jwt-handbook
  static List<int> decodeJWTBase64(String src) {
    src = src.replaceAll('-', '+').replaceAll('_', '/');
    var padding = '=' * (src.length % 4);
    src += padding;
    return conv.base64Url.decode(src);
  }
}

