const headers = {
  host: "api.sportradar.com",
};
const config = {
  accept: "application/json",
  headers: headers,
  url: `https://api.sportradar.com/soccer/trial/v4/en/seasons/sr%3Aseason%3A118689/standings.json?api_key=${args[0]}`,
};
const apiResponse = Functions.makeHttpRequest(config);
if (apiResponse.error) {
  console.error(apiResponse.error);
  throw Error("Request failed");
}
const { data } = await apiResponse;
let standingsObj = data.standings[0].groups[0].standings;
let standingsString = "";
for (let x = 0; x < standingsObj.length; x++) {
  standingsString =
    standingsString + standingsObj[x].competitor.abbreviation + "/";
}
console.log(standingsString);
return Functions.encodeString(standingsString);
