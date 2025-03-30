@IsTest
public class LacoreConnectServiceMock implements HttpCalloutMock {
    private Integer statusCode;
    private String status;
    private String body;
    
    public LacoreConnectServiceMock() {
        this(200, 'OK', '{"success":true}');
    }
    
    public LacoreConnectServiceMock(Integer statusCode, String status, String body) {
        this.statusCode = statusCode;
        this.status = status;
        this.body = body;
    }
    
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(statusCode);
        response.setStatus(status);
        response.setBody(body);
        return response;
    }
} 