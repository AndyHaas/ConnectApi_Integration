/**
 * @description Test class for the GetStatisticsAction class.
 * This class contains test methods to verify the functionality of retrieving
 * statistics through the LacoreConnect service.
 */
@IsTest
public class GetStatisticsActionTest {
    
    /**
     * @description Test setup method to initialize test data
     */
    @TestSetup
    public static void setup() {
        System.debug('Starting GetStatisticsActionTest setup');
        try {
            // Add any test setup if needed
            System.debug('GetStatisticsActionTest setup completed successfully');
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error in GetStatisticsActionTest setup: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
            throw e;
        }
    }
    
    /**
     * @description Test method to verify successful retrieval of statistics with basic parameters
     */
    @IsTest
    public static void testGetStatistics() {
        System.debug('Starting testGetStatistics');
        Test.startTest();
        
        try {
            // Create test request
            System.debug('Creating test request with basic parameters');
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
            System.debug('Executing GetStatisticsAction');
            List<GetStatisticsAction.GetStatisticsResponse> responses = GetStatisticsAction.execute(new List<GetStatisticsAction.GetStatisticsRequest>{request});
            
            // Verify response
            System.debug('Verifying response');
            System.assertEquals(1, responses.size(), 'Should have one response');
            System.assertEquals(true, responses[0].success, 'Response should be successful');
            System.assertNotEquals(null, responses[0].data, 'Response data should not be null');
            
            System.debug('testGetStatistics completed successfully');
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error in testGetStatistics: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
            throw e;
        }
        
        Test.stopTest();
    }
    
    /**
     * @description Test method to verify successful retrieval of statistics with different grouping
     */
    @IsTest
    public static void testGetStatisticsWithDifferentGroupBy() {
        System.debug('Starting testGetStatisticsWithDifferentGroupBy');
        Test.startTest();
        
        try {
            // Create test request with weekly grouping
            System.debug('Creating test request with weekly grouping');
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
            System.debug('Executing GetStatisticsAction with weekly grouping');
            List<GetStatisticsAction.GetStatisticsResponse> responses = GetStatisticsAction.execute(new List<GetStatisticsAction.GetStatisticsRequest>{request});
            
            // Verify response
            System.debug('Verifying response');
            System.assertEquals(1, responses.size(), 'Should have one response');
            System.assertEquals(true, responses[0].success, 'Response should be successful');
            System.assertNotEquals(null, responses[0].data, 'Response data should not be null');
            
            System.debug('testGetStatisticsWithDifferentGroupBy completed successfully');
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error in testGetStatisticsWithDifferentGroupBy: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
            throw e;
        }
        
        Test.stopTest();
    }
    
    /**
     * @description Test method to verify error handling
     */
    @IsTest
    public static void testErrorHandling() {
        System.debug('Starting testErrorHandling');
        Test.startTest();
        
        try {
            // Create test request with missing required fields
            System.debug('Creating test request with missing required fields');
            GetStatisticsAction.GetStatisticsRequest request = new GetStatisticsAction.GetStatisticsRequest();
            request.request = new StatisticsRequestDto();
            
            // Call action
            System.debug('Executing GetStatisticsAction with invalid request');
            List<GetStatisticsAction.GetStatisticsResponse> responses = GetStatisticsAction.execute(new List<GetStatisticsAction.GetStatisticsRequest>{request});
            
            // Verify error response
            System.debug('Verifying error response');
            System.assertEquals(1, responses.size(), 'Should have one response');
            System.assertEquals(false, responses[0].success, 'Response should not be successful');
            System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
            
            System.debug('testErrorHandling completed successfully');
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error in testErrorHandling: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
            throw e;
        }
        
        Test.stopTest();
    }
} 