const RAPID_API_KEY = args[0];

const headers = {
  "x-rapidapi-key": RAPID_API_KEY,
  "x-rapidapi-host": "heisenbug-premier-league-live-scores-v1.p.rapidapi.com",
};

const config = {
  method: "GET",
  headers: headers,
  url: "https://heisenbug-premier-league-live-scores-v1.p.rapidapi.com/api/premierleague/table",
};

const apiResponse = Functions.makeHttpRequest(config);

if (apiResponse.error) {
  console.error(apiResponse.error);
  throw Error("Request failed");
}

const { data } = await apiResponse;
let addString;
let standingsObj = data.records;
let standingsString = "";
for (let x = 0; x < standingsObj.length; x++) {
  if (standingsObj[x].team.slice(0, 3) == "Man") {
    if (standingsObj[x].team.split(" ")[1] == "United") {
      addString = "MUN";
    } else addString = "MCI";
    standingsString = standingsString + addString + "/";
  } else {
    standingsString =
      standingsString + standingsObj[x].team.slice(0, 3).toUpperCase() + "/";
  }
}
console.log(standingsString);
return Functions.encodeString(standingsString);

//Format: ARS/MCI/LIV/AST/TOT/MUN/NEW/WES/CHE/BOU/WOL/BRI/EVE/FUL/CRY/BRE/NOT/LUT/BUR/SHE/
