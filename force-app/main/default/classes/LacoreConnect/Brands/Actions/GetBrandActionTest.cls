@IsTest
private class GetBrandActionTest {
    @IsTest
    static void testExecute() {
        // Given
        String brandId = '123';
        GetBrandAction.GetBrandRequest request = new GetBrandAction.GetBrandRequest();
        request.brandId = brandId;
        
        // When
        List<GetBrandAction.GetBrandResponse> responses = GetBrandAction.execute(new List<GetBrandAction.GetBrandRequest>{request});
        
        // Then
        System.assertNotEquals(null, responses);
        System.assertEquals(1, responses.size());
        System.assertEquals(true, responses[0].success);
    }
} 