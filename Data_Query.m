let
    // Retrieve the access token from the previous query
    access_token = Auth_Query,

    // Define the API endpoint and request headers
    url = "https://api.bms.kaseya.com/v2/servicedesk/tickets/",
    headers = [        #"Authorization" = "Bearer " & access_token,        #"Content-Type" = "application/json",        #"Accept" = "application/json"    ],

    // Send the request and retrieve the response
    response = Web.Contents(url, [Headers=headers]),
    jsonResponse = Json.Document(response),

    // Transform the response into a table (if necessary)

    

    resultList = jsonResponse[result],
    table = Table.FromRecords(resultList),
    #"Changed Type" = Table.TransformColumnTypes(table,{{"openDate", type datetime}})



in
    #"Changed Type"
