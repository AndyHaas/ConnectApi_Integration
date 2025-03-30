@IsTest
private class CalculateRatesActionTest {
    
    @TestSetup
    static void setup() {
        // Create test data
    }
    
    @IsTest
    static void testCalculateRates() {
        // Prepare test request
        CalculateRatesAction.CalculateRatesRequest request = new CalculateRatesAction.CalculateRatesRequest();
        request.brandId = 'test-brand-id';
        request.warehouseId = 'test-warehouse-id';
        request.destinationCountry = 'US';
        request.destinationState = 'CA';
        request.destinationCity = 'San Francisco';
        request.destinationZip = '94105';
        request.destinationAddress1 = '123 Test St';
        
        CalculateRatesAction.RateItem item = new CalculateRatesAction.RateItem();
        item.sku = 'TEST-SKU';
        item.quantity = 1;
        item.weight = 1.0;
        item.length = 10.0;
        item.width = 10.0;
        item.height = 10.0;
        request.items = new List<CalculateRatesAction.RateItem>{ item };
        
        // Execute test
        Test.startTest();
        List<CalculateRatesAction.CalculateRatesResponse> responses = 
            CalculateRatesAction.execute(new List<CalculateRatesAction.CalculateRatesRequest>{ request });
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should have one response');
        CalculateRatesAction.CalculateRatesResponse response = responses[0];
        System.assertNotEquals(null, response, 'Response should not be null');
        System.assertNotEquals(null, response.data, 'Response data should not be null');
    }
    
    @IsTest
    static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        CalculateRatesAction.CalculateRatesRequest request = new CalculateRatesAction.CalculateRatesRequest();
        
        // Call action
        List<CalculateRatesAction.CalculateRatesResponse> responses = 
            CalculateRatesAction.execute(new List<CalculateRatesAction.CalculateRatesRequest>{ request });
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testCalculateRatesWithMultipleItems() {
        // Prepare test request
        CalculateRatesAction.CalculateRatesRequest request = new CalculateRatesAction.CalculateRatesRequest();
        request.brandId = 'test-brand-id';
        request.warehouseId = 'test-warehouse-id';
        request.destinationCountry = 'US';
        request.destinationState = 'CA';
        request.destinationCity = 'San Francisco';
        request.destinationZip = '94105';
        request.destinationAddress1 = '123 Test St';
        
        // Create multiple items
        List<CalculateRatesAction.RateItem> items = new List<CalculateRatesAction.RateItem>();
        
        CalculateRatesAction.RateItem item1 = new CalculateRatesAction.RateItem();
        item1.sku = 'TEST-SKU-1';
        item1.quantity = 2;
        item1.weight = 1.0;
        item1.length = 10.0;
        item1.width = 10.0;
        item1.height = 10.0;
        items.add(item1);
        
        CalculateRatesAction.RateItem item2 = new CalculateRatesAction.RateItem();
        item2.sku = 'TEST-SKU-2';
        item2.quantity = 1;
        item2.weight = 2.0;
        item2.length = 15.0;
        item2.width = 15.0;
        item2.height = 15.0;
        items.add(item2);
        
        request.items = items;
        
        // Execute test
        Test.startTest();
        List<CalculateRatesAction.CalculateRatesResponse> responses = 
            CalculateRatesAction.execute(new List<CalculateRatesAction.CalculateRatesRequest>{ request });
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should have one response');
        CalculateRatesAction.CalculateRatesResponse response = responses[0];
        System.assertNotEquals(null, response, 'Response should not be null');
        System.assertNotEquals(null, response.data, 'Response data should not be null');
    }
} 