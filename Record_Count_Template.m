let
    access_token = #"Auth_Query",
    url = "https://api.bms.kaseya.com/v2/servicedesk/tickets/",
    queryParameters = [
        Filter.openDateFrom = "2023-02-01T16:20:01.241Z", 
        Filter.openDateTo = "2023-02-10T16:20:01.241Z",
        pageSize = "97", // Set the pageSize to the same value as in your main query
        pageNumber = "0"
    ],
    headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],
    response = Web.Contents(url, [Headers=headers, Query=queryParameters]),
    jsonResponse = Json.Document(response),
    totalRecords = jsonResponse[totalRecords], // Use the 'totalRecords' field
    totalPages = Number.RoundUp(totalRecords / 97) // Calculate the total number of pages based on totalRecords and pageSize
in
    [TotalRecords = totalRecords, TotalPages = totalPages]
