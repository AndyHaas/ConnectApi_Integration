/**
 * @description Test class for GetBrandAction
 */
@IsTest
public class GetBrandActionTest {

    @TestSetup
    static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }

    @IsTest
    public static void testExecuteWithNullResponse() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', null));
        
        List<GetBrandAction.GetBrandResponse> responses = GetBrandAction.execute(); 
        
        System.assertNotEquals(null, responses);
        System.assertEquals(1, responses.size());
        System.assertEquals(true, responses[0].success);
        System.assertEquals(null, responses[0].data);
    }

    @IsTest
    public static void testExecuteWithEmptyResponse() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', '[]'));
        
        List<GetBrandAction.GetBrandResponse> responses = GetBrandAction.execute();
        
        System.assertNotEquals(null, responses);
        System.assertEquals(1, responses.size());
        System.assertEquals(true, responses[0].success);
        System.assertEquals(null, responses[0].data);
    }

    @IsTest
    public static void testExecuteWithInvalidResponse() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', '{"invalid": "response"}'));
        
        List<GetBrandAction.GetBrandResponse> responses = GetBrandAction.execute();
        
        System.assertNotEquals(null, responses);
        System.assertEquals(1, responses.size());
        System.assertEquals(true, responses[0].success);
        System.assertEquals(null, responses[0].data);
    }
} 