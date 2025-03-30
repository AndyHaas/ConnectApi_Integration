@IsTest
private class DTOsTest {
    @IsTest
    static void testSerialize() {
        TestClass testObj = new TestClass();
        testObj.name = 'Test Name';
        testObj.value = 42;
        
        String jsonString = DTOs.serialize(testObj);
        System.assertEquals('{"name":"Test Name","value":42}', jsonString, 'Expected serialized JSON string');
    }
    
    @IsTest
    static void testDeserialize() {
        String jsonString = '{"name":"Test Name","value":42}';
        TestClass testObj = (TestClass)DTOs.deserialize(jsonString, TestClass.class);
        
        System.assertEquals('Test Name', testObj.name, 'Expected deserialized name');
        System.assertEquals(42, testObj.value, 'Expected deserialized value');
    }
    
    @IsTest
    static void testDeserializeError() {
        String jsonString = '{"error":"invalid_request","message":"Invalid request","details":["Invalid parameters"]}';
        DTOs.ErrorResponseDto error = DTOs.deserializeError(jsonString);
        
        System.assertEquals('invalid_request', error.error, 'Expected error code');
        System.assertEquals('Invalid request', error.message, 'Expected error message');
        System.assertEquals(1, error.details.size(), 'Expected one detail');
        System.assertEquals('Invalid parameters', error.details[0], 'Expected detail message');
    }
    
    private class TestClass {
        public String name;
        public Integer value;
    }
} 