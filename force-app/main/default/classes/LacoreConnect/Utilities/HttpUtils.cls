public class HttpUtils {
    /**
     * Builds a query string from a map of parameters
     * @param params Map of parameter names to their values
     * @return A properly formatted query string starting with '?' if there are parameters, empty string otherwise
     */
    public static String buildQueryString(Map<String, String> params) {
        if (params == null || params.isEmpty()) {
            return '';
        }
        
        List<String> queryParams = new List<String>();
        for (String key : params.keySet()) {
            String value = params.get(key);
            if (value != null && value != '') {
                queryParams.add(EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(value, 'UTF-8'));
            }
        }
        
        return queryParams.isEmpty() ? '' : '?' + String.join(queryParams, '&');
    }
} 