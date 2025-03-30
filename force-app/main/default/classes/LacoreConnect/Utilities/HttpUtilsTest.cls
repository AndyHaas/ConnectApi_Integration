@IsTest
private class HttpUtilsTest {
    @IsTest
    static void testBuildQueryStringWithNullParams() {
        String queryString = HttpUtils.buildQueryString(null);
        System.assertEquals('', queryString, 'Expected empty string for null params');
    }
    
    @IsTest
    static void testBuildQueryStringWithEmptyParams() {
        String queryString = HttpUtils.buildQueryString(new Map<String, String>());
        System.assertEquals('', queryString, 'Expected empty string for empty params');
    }
    
    @IsTest
    static void testBuildQueryStringWithValidParams() {
        Map<String, String> params = new Map<String, String>{
            'brandId' => 'test-brand-id',
            'warehouseId' => 'test-warehouse-id',
            'status' => 'test-status'
        };
        
        String queryString = HttpUtils.buildQueryString(params);
        System.assertEquals('?brandId=test-brand-id&warehouseId=test-warehouse-id&status=test-status', queryString, 'Expected valid query string');
    }
    
    @IsTest
    static void testBuildQueryStringWithBlankValues() {
        Map<String, String> params = new Map<String, String>{
            'brandId' => 'test-brand-id',
            'warehouseId' => '',
            'status' => null
        };
        
        String queryString = HttpUtils.buildQueryString(params);
        System.assertEquals('?brandId=test-brand-id', queryString, 'Expected query string without blank values');
    }
    
    @IsTest
    static void testBuildQueryStringWithSpecialCharacters() {
        Map<String, String> params = new Map<String, String>{
            'brandId' => 'test brand id',
            'warehouseId' => 'test/warehouse/id',
            'status' => 'test&status'
        };
        
        String queryString = HttpUtils.buildQueryString(params);
        System.assertEquals('?brandId=test+brand+id&warehouseId=test%2Fwarehouse%2Fid&status=test%26status', queryString, 'Expected encoded query string');
    }
} 