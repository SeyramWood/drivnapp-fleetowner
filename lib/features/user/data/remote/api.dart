var headers = {
   'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
   'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('/fleet-owners'));
request.body = '''<body data here>''';
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
   print(await response.stream.bytesToString());
}
else {
   print(response.reasonPhrase);
}