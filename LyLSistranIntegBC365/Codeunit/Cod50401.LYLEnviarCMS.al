codeunit 50401 LYLEnviarCMS
{
    procedure SendPost(body: Text; method: text) ResponseData: Text
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        contentHeaders2: HttpHeaders;
        content: HttpContent;
        LyLIntegConfig: Record LYLConfigIntegSistran;
    begin
        LyLIntegConfig.FindFirst();
        contentHeaders.Clear();

        //  request.GetHeaders(contentHeaders);
        //  contentHeaders.Add('Authorization', LyLIntegConfig.KeyServicio);

        Client.DefaultRequestHeaders().TryAddWithoutValidation('Authorization', LyLIntegConfig.KeyServicio);

        //  contentHeaders := Client.DefaultRequestHeaders().TryAddWithoutValidation('Authorization', LyLIntegConfig.KeyServicio);
        content.WriteFrom(body);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');

        Client.Post(LyLIntegConfig.UrlServicio + method, content, response);

        response.Content().ReadAs(ResponseData);
    end;

    procedure ProcessResponse(ResponseData: text): text
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        response: text;
    begin
        JsonObject.ReadFrom(ResponseData);
        if JsonObject.Get('message', JsonToken) then begin
            JsonToken.WriteTo(response);
            if response.Contains('Conexión exitosa') then
                exit('OK');
            exit('ERROR: ' + response)
        end;
    end;
}