/**
 * @description Mock class for testing LacoreConnectService HTTP callouts.
 * This class implements HttpCalloutMock to provide test responses for HTTP requests.
 */
@IsTest
public class LacoreConnectServiceMock implements HttpCalloutMock {
    /** HTTP status code for the mock response */
    private Integer statusCode;
    /** HTTP status message for the mock response */
    private String status;
    /** Response body for the mock response */
    private String body;
    
    /**
     * @description Default constructor that creates a successful mock response
     */
    public LacoreConnectServiceMock() {
        this(200, 'OK', '{"success":true}');
    }
    
    /**
     * @description Constructor that allows customizing the mock response
     * @param statusCode The HTTP status code to return
     * @param status The HTTP status message to return
     * @param body The response body to return
     */
    public LacoreConnectServiceMock(Integer statusCode, String status, String body) {
        this.statusCode = statusCode;
        this.status = status;
        this.body = body;
    }
    
    /**
     * @description Implements the HttpCalloutMock interface to provide mock responses
     * @param request The HTTP request that triggered this mock
     * @return HttpResponse The mock HTTP response
     */
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(statusCode);
        response.setStatus(status);
        response.setBody(body);
        return response;
    }
} 