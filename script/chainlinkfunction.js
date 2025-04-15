
const apiResponse = await Functions.makeHttpRequest(
    {url: `http://api.football-data.org/v4/competitions/PL/standings`,
  headers: 
  {"X-Auth-Token": secrets.API_KEY}}
)

if (apiResponse.error) {
  console.error(apiResponse.error)
  throw Error("Request failed")
}

const { data } = apiResponse;
console.log(data.filters.season);
let standingsObj = data.standings[0].table;
let standingsString = "";
for (let x = 0; x < standingsObj.length; x++) {
  standingsString=standingsString+standingsObj[x].team.tla;
}
///LIVARSNOTCHEMCIAVLNEWBHABOUFULCRYBREMUNEVEWHUTOTWOLIPSLEISOU
console.log('API response data:', JSON.stringify(data, null, 2));

return Functions.encodeString(standingsString);

