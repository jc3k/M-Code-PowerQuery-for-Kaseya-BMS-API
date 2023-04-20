let
    // Retrieve the access token from the previous query
    access_token = #"Auth_Query",

    // Define the API endpoint and request headers
    url = "https://api.bms.kaseya.com/v2/servicedesk/tickets/",
    queryParameters = [
        
    ],

    headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],

    // Send the request and retrieve the response
    response = Web.Contents(url, [Headers=headers, Query=queryParameters]),
    jsonResponse = Json.Document(response),

    // Transform the response into a table (if necessary)
    resultList = jsonResponse[result],
    table = Table.FromRecords(resultList)

in
    table
    
    
    
    let
    // Retrieve the access token from the previous query
    access_token = #"Auth_Query",

    // Define the API endpoint and request headers
    url = "https://api.bms.kaseya.com/v2/servicedesk/tickets/searchselect",
    queryParameters = [
        //title = "string", 
        //account = "string", 
        //ticketNumber = "string", 
        //statusNames = "string", 
        //priorityNames = "string", 
        //ticketTypeNames = "string", 
        //issueTypeNames = "string", 
        //serviceLevelAgreementNames = "string", 
        //excludeCompleted = 0, 
        //openDateFrom = "2023-02-01T16:20:01.241Z", 
        //openDateTo = "2023-02-10T16:20:01.241Z",
        //completedDateFrom = "2023-04-10T16:20:01.241Z", 
        //completedDateTo = "2023-04-10T16:20:01.241Z", 
        //createdOnFrom = "2023-04-10T16:20:01.241Z", 
        //createdOnTo = "2023-04-10T16:20:01.241Z",
        //sort = "string",
        //exclude = "string",
        Filter.OpenDateFrom = "2023-02-01", 
        Filter.OpenDateTo = "2023-02-02",
        PageSize = "11",
        pageNumber = "0"
    ],

    // Get all pages of data using the GetPagedData function
    result = GetPagedData(url, queryParameters, access_token),

    // Get the combined data table from the result
    table = result[Data]

in
    table
