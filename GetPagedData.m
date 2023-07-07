let
    GetPagedData = (baseUrl as text, queryParameters as record, access_token as text, relativePath as text, optional currentPage as number, optional maxPages as number) =>
let
    pageNumber = if currentPage = null then 1 else currentPage,
    updatedParameters = Record.AddField(Record.RemoveFields(queryParameters, {"pageNumber"}), "pageNumber", Text.From(pageNumber)),
    headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],
    options = [Headers=headers, Query=updatedParameters, RelativePath=relativePath],
    response = Web.Contents(baseUrl, options),
    jsonResponse = Json.Document(response),
    resultList = jsonResponse[result],
    data = Table.FromRecords(resultList),
    nextPage = if List.IsEmpty(resultList) or (maxPages <> null and pageNumber >= maxPages) then null else pageNumber + 1,
    nextData = if nextPage = null then null else @GetPagedData(baseUrl, queryParameters, access_token, relativePath, nextPage, maxPages),
    combinedData = if nextPage = null then data else Table.Combine({data, nextData[Data]}),
    loggedURLs = if nextPage = null then {baseUrl & relativePath & "?" & Uri.BuildQueryString(updatedParameters)} else {baseUrl & relativePath & "?" & Uri.BuildQueryString(updatedParameters)} & nextData[LoggedURLs]
in
    [Data = combinedData, LoggedURLs = loggedURLs]
in
    GetPagedData
