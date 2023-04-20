let
    // Retrieve the access token from the previous query
    access_token = #"Auth_Query",

    // Define the API endpoint and request headers
    url = "https://api.bms.kaseya.com/v2/system/statuses/",

    LoadData = (url as text, access_token as text, pageNumber as number, pageSize as number) =>
    let
        queryParameters = [
            PageSize = Text.From(pageSize),
            pageNumber = Text.From(pageNumber)
        ],
        headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],
        response = Web.Contents(url, [Headers=headers, Query=queryParameters]),
        jsonResponse = Json.Document(response),
        resultList = jsonResponse[result],
        data = Table.FromRecords(resultList),
        nextPageNumber = pageNumber + 1,
        nextData = if Table.IsEmpty(data) then null else @LoadData(url, access_token, nextPageNumber, pageSize),
        combinedData = if nextData = null then data else Table.Combine({data, nextData})
    in
        combinedData,

    // Initialize the recursive function with the starting page number and page size
    table = LoadData(url, access_token, 0, 100)

in
    table
