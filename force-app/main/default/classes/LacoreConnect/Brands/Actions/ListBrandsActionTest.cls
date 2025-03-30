@IsTest
private class ListBrandsActionTest {
    
    @TestSetup
    static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    static void testListBrands() {
        Test.startTest();
        
        // Create test request
        ListBrandsAction.ListBrandsRequest request = new ListBrandsAction.ListBrandsRequest();
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'name';
        request.sortDir = 'asc';
        
        // Call action
        List<LacoreConnectService.ApiResponse> responses = ListBrandsAction.execute(new List<ListBrandsAction.ListBrandsRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(200, responses[0].statusCode, 'Status code should be 200');
        System.assertEquals(true, responses[0].isSuccess, 'Response should be successful');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testListBrandsWithDefaults() {
        Test.startTest();
        
        // Create test request with default values
        ListBrandsAction.ListBrandsRequest request = new ListBrandsAction.ListBrandsRequest();
        
        // Call action
        List<LacoreConnectService.ApiResponse> responses = ListBrandsAction.execute(new List<ListBrandsAction.ListBrandsRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(200, responses[0].statusCode, 'Status code should be 200');
        System.assertEquals(true, responses[0].isSuccess, 'Response should be successful');
        
        Test.stopTest();
    }
} 