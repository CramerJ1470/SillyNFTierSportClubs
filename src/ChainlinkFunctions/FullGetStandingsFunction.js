

    const FOOTBALL_DATA_API_KEY= args[0];
       
    const headers = {
        'Content-Type': 'application/json',
        'X-Auth-Token': FOOTBALL_DATA_API_KEY
    }
    const config = {
        method: 'GET',
        headers: headers,
        url: `http://api.football-data.org/v4/competitions/PL/standings`
    }

const apiResponse = Functions.makeHttpRequest(config);
  
  if (apiResponse.error) {
  console.error(apiResponse.error)
  throw Error("Request failed")
  }
  
  const { data } = await apiResponse;
  let standingsObj = data.standings[0].table;
  let standingsString = "";
  for (let x = 0; x < standingsObj.length; x++) {
  standingsString=standingsString+standingsObj[x].team.tla;
  }
  ///LIVARSNOTCHEMCIAVLNEWBHABOUFULCRYBREMUNEVEWHUTOTWOLIPSLEISOU

  
  return Functions.encodeString(standingsString);
