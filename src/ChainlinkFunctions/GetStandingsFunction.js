

const request = await Functions.makeHttpRequest({
    url: "https://heisenbug-premier-league-live-scores-v1.p.rapidapi.com/api/premierleague/table",
    method: "GET",
    headers: {
      "X-Rapidapi-Key": secrets.X_RAPIDAPI_KEY,
      "Content-Type": "application/json",
    },
  });
  
  if (request.error) {
    console.error("HTTP Request Failed:", request.error);
    throw new Error(`HTTP Request Failed: ${request.error}`);
  }
  
  // Extracting top 5 teams from the response to reduce size
  const standings = request.data.records || []; // Take only the top 5 teams
  const filteredData = standings.map((team,index) => (
    {name:team.team + " FC", standing:index}// Assuming the API returns a field like 'teamName'
      // Assuming the API returns a field like 'points'
  ));
  filteredData.sort((a, b) => a.name.localeCompare(b.name));
  
  
  let allNamesSmashed =[];
  filteredData.forEach((team) => {allNamesSmashed.push(team.standing);});
  console.log(allNamesSmashed); 
  
  // Convert the filtered data to a string and ensure it's <256 bytes
  const responseString = JSON.stringify(allNamesSmashed);
  
  if (responseString.length > 256) {
    throw new Error("Filtered response still exceeds 256 bytes");
  }
  
  return Functions.encodeString(responseString);