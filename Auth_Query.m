let
    // Define the base URL
    baseUrl = "https://api.bms.kaseya.com/v2/",

    // Define the request body, insert your own credentials here
    grantType = "password",
    userName = "uuuuuuuuuuu",
    password = "pppppppppp",
    tenant = "cccccccccccc",
    body = "grantType=" & grantType & "&userName=" & userName & "&password=" & password & "&tenant=" & tenant,

    // Define the request headers
    headers = [
        #"Content-Type" = "application/x-www-form-urlencoded",
        #"Accept" = "application/json"
    ],

    // Send the request and retrieve the response
    response = Web.Contents(baseUrl, [
        Headers=headers, 
        Content=Text.ToBinary(body), 
        RelativePath="security/authenticate"
    ]),
    jsonResponse = Json.Document(response),

    // Extract the access token from the response
    access_token = jsonResponse[result][accessToken]
in
    access_token
