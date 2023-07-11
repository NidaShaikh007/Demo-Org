global class OppAttachment {
 //  @future(callout=true)

public static void uploadFile(Blob file_body, String file_name,string Netsuiteid){
  

      String boundary = ' ';
      String header = '--'+boundary+'\r\nContent-Disposition: form-data; name="file"; filename="'+file_name+'"\r\nContent-Type: application/octet-stream';
      String footer = '\r\n--'+boundary+'--';              
      String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
     
    while(headerEncoded.endsWith('='))
      {
       header+=' ';
       headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
      }
      String bodyEncoded = EncodingUtil.base64Encode(file_body);
      String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));

      Blob bodyBlob = null;
     String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
      if(last4Bytes.endsWith('='))
      {
           Blob decoded4Bytes = EncodingUtil.base64Decode(last4Bytes);
           HttpRequest tmp = new HttpRequest();
           tmp.setBodyAsBlob(decoded4Bytes);
           String last4BytesFooter = tmp.getBody()+footer;   
           bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded.substring(0,bodyEncoded.length()-4)+EncodingUtil.base64Encode(Blob.valueOf(last4BytesFooter)));
      }
      else
      {
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
      }

      HttpRequest req = new HttpRequest();
      req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
      req.setMethod('POST');
//      req.setEndpoint(endpoint);
      req.setBodyAsBlob(bodyBlob);
         req.setCompressed(true);
      req.setTimeout(120000);
    
      Http http1 = new Http();
      
HTTPResponse resp = http1.send(req);
}
}