@IsTest
private class GetStatisticsActionTest {
    
    @TestSetup
    static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    static void testGetStatistics() {
        Test.startTest();
        
        // Create test request
        GetStatisticsAction.GetStatisticsRequest request = new GetStatisticsAction.GetStatisticsRequest();
        request.request = new StatisticsRequestDto();
        request.request.brandId = 'test-brand';
        request.request.warehouseId = 'test-warehouse';
        request.request.startDate = DateTime.now().addDays(-30);
        request.request.endDate = DateTime.now();
        request.request.groupBy = StatisticsGroupBy.DAY;
        request.request.metrics = new List<StatisticsMetric>{
            StatisticsMetric.ORDERS,
            StatisticsMetric.SHIPMENTS,
            StatisticsMetric.REVENUE
        };
        
        // Call action
        List<GetStatisticsAction.GetStatisticsResponse> responses = GetStatisticsAction.execute(new List<GetStatisticsAction.GetStatisticsRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertNotEquals(null, responses[0].data, 'Response data should not be null');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testGetStatisticsWithDifferentGroupBy() {
        Test.startTest();
        
        // Create test request with weekly grouping
        GetStatisticsAction.GetStatisticsRequest request = new GetStatisticsAction.GetStatisticsRequest();
        request.request = new StatisticsRequestDto();
        request.request.brandId = 'test-brand';
        request.request.warehouseId = 'test-warehouse';
        request.request.startDate = DateTime.now().addDays(-90);
        request.request.endDate = DateTime.now();
        request.request.groupBy = StatisticsGroupBy.WEEK;
        request.request.metrics = new List<StatisticsMetric>{
            StatisticsMetric.ORDERS,
            StatisticsMetric.SHIPMENTS,
            StatisticsMetric.REVENUE
        };
        
        // Call action
        List<GetStatisticsAction.GetStatisticsResponse> responses = GetStatisticsAction.execute(new List<GetStatisticsAction.GetStatisticsRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertNotEquals(null, responses[0].data, 'Response data should not be null');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        GetStatisticsAction.GetStatisticsRequest request = new GetStatisticsAction.GetStatisticsRequest();
        request.request = new StatisticsRequestDto();
        
        // Call action
        List<GetStatisticsAction.GetStatisticsResponse> responses = GetStatisticsAction.execute(new List<GetStatisticsAction.GetStatisticsRequest>{request});
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
} 