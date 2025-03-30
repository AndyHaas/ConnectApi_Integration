public class DTOs {
    public class ErrorResponseDto {
        public String error;
        public String message;
        public List<String> details;
    }
    
    // Helper methods for JSON serialization/deserialization
    public static String serialize(Object obj) {
        return JSON.serialize(obj);
    }
    
    public static Object deserialize(String jsonString, Type targetType) {
        return JSON.deserialize(jsonString, targetType);
    }
    
    public static ErrorResponseDto deserializeError(String jsonString) {
        return (ErrorResponseDto)JSON.deserialize(jsonString, ErrorResponseDto.class);
    }
} 