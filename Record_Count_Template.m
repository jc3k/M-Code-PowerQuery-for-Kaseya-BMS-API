let
    BMS_Record_Count_Template = let
    access_token = BMS_Auth_Query,
    dateRange = DateRange(10, false), // Get the past 10 days without including today
    baseUrl = "https://api.bms.kaseya.com/",
    relativePath = "v2/servicedesk/tickets/",
    queryParameters = [
        Filter.openDateFrom = dateRange[From], 
        Filter.openDateTo = dateRange[To],
        pageSize = "97", // Set the pageSize to the same value as in your main query
        pageNumber = "0"
    ],
    headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],
    options = [Headers=headers, Query=queryParameters, RelativePath=relativePath],
    response = Web.Contents(baseUrl, options),
    jsonResponse = Json.Document(response),
    totalRecords = jsonResponse[totalRecords], // Use the 'totalRecords' field
    totalPages = Number.RoundUp(totalRecords / 97), // Calculate the total number of pages based on totalRecords and pageSize

    // Convert record to table
    result = Record.ToTable([TotalRecords = totalRecords, TotalPages = totalPages])
in
    result
in
    BMS_Record_Count_Template
