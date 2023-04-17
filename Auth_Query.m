let
    // Define the API endpoint
    url = "https://api.bms.kaseya.com/v2/security/authenticate",

    // Define the request body
    grantType = "password",
    userName = "uuuuuuuuuuuuu",
    password = "ppppppppppppp",
    tenant = "superior managed it services llc",
    body = "grantType=" & grantType & "&userName=" & userName & "&password=" & password & "&tenant=" & tenant,

    // Define the request headers
    headers = [
        #"Content-Type" = "application/x-www-form-urlencoded",
        #"Accept" = "application/json"
    ],

    // Send the request and retrieve the response
    response = Web.Contents(url, [Headers=headers, Content=Text.ToBinary(body)]),
    jsonResponse = Json.Document(response),

    // Extract the access token from the response
    access_token = jsonResponse[result][accessToken]
in
    access_token
