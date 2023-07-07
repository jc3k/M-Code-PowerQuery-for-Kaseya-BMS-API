let
    // Retrieve the access token from the previous query
    access_token = BMS_Auth_Query,

    // Define the base API endpoint and RelativePath
    baseUrl = "https://api.bms.kaseya.com/",
    relativePath = "v2/system/statuses/",

    LoadData = (baseUrl as text, relativePath as text, access_token as text, pageNumber as number, pageSize as number) =>
    let
        queryParameters = [
            PageSize = Text.From(pageSize),
            pageNumber = Text.From(pageNumber)
        ],
        headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],
        options = [Headers=headers, Query=queryParameters, RelativePath=relativePath],
        response = Web.Contents(baseUrl, options),
        jsonResponse = Json.Document(response),
        resultList = jsonResponse[result],
        data = Table.FromRecords(resultList),
        nextPageNumber = pageNumber + 1,
        nextData = if Table.IsEmpty(data) then null else @LoadData(baseUrl, relativePath, access_token, nextPageNumber, pageSize),
        combinedData = if nextData = null then data else Table.Combine({data, nextData})
    in
        combinedData,

    // Initialize the recursive function with the starting page number and page size
    table = LoadData(baseUrl, relativePath, access_token, 0, 100)

in
    table
