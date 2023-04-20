let
    GetPagedData = (url as text, queryParameters as record, access_token as text, optional currentPage as number, optional maxPages as number) =>
let
    pageNumber = if currentPage = null then 1 else currentPage,
    updatedParameters = Record.AddField(Record.RemoveFields(queryParameters, {"pageNumber"}), "pageNumber", Text.From(pageNumber)),
    headers = [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json", #"Accept" = "application/json"],
    response = Web.Contents(url, [Headers=headers, Query=updatedParameters]),
    jsonResponse = Json.Document(response),
    resultList = jsonResponse[result],
    data = Table.FromRecords(resultList),
    nextPage = if List.IsEmpty(resultList) or (maxPages <> null and pageNumber >= maxPages) then null else pageNumber + 1,
    nextData = if nextPage = null then null else @GetPagedData(url, queryParameters, access_token, nextPage, maxPages),
    combinedData = if nextPage = null then data else Table.Combine({data, nextData[Data]}),
    loggedURLs = if nextPage = null then {url & "?" & Uri.BuildQueryString(updatedParameters)} else {url & "?" & Uri.BuildQueryString(updatedParameters)} & nextData[LoggedURLs]
in
    [Data = combinedData, LoggedURLs = loggedURLs]
in
    GetPagedData
