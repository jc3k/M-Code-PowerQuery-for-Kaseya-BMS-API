let
    // Retrieve the access token from the previous query
    access_token = BMS_Auth_Query,

    // Get the date range for the past 90 days, excluding today
    dateRange = DateRange(10, false),

    // Define the base API endpoint and RelativePath
    baseUrl = "https://api.bms.kaseya.com/",
    relativePath = "v2/servicedesk/tickets/searchselect",
    queryParameters = [
        // Other parameters ...
        Filter.OpenDateFrom = dateRange[From],
        Filter.OpenDateTo = dateRange[To],
        PageSize = "11",
        pageNumber = "0"
    ],

    // Get all pages of data using the GetPagedData function
    
    result = GetPagedData(baseUrl, queryParameters, access_token, relativePath),

    // Get the combined data table from the result
    table = result[Data]

in
    table
