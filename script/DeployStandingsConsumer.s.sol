// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import { GettingStartedFunctionsConsumer } from "../src/contracts/StandingsConsumerCF.sol";

// import {AddConsumer, CreateSubscription, FundSubscription} from "./Interactions.s.sol";

contract DeployGettingStartedFunctionsConsumer(args) is Script returns (string){
    function run() external{
      
        address account = 0x83E048fE9699C3d9a81ba9217Ccd064d148cE2A9;
        string memory standings;

        vm.startBroadcast(account);
       GettingStartedFunctionsConsumer standingsConsumer = new GettingStartedFunctionsConsumer(
          
        );
      standings = standingsConsumer.sendRequest(2362,[args[0]]

        vm.stopBroadcast();

        // We already have a broadcast in here
        return standings;
    }       
}



    const RAPID_API_KEY= args[0];
       
    const headers =   {
		'x-rapidapi-key': RAPID_API_KEY,
		'x-rapidapi-host': 'heisenbug-premier-league-live-scores-v1.p.rapidapi.com'
	}

    const config = {
        method: 'GET',
        headers: headers,
        url: 'https://heisenbug-premier-league-live-scores-v1.p.rapidapi.com/api/premierleague/table'
    }

const apiResponse = Functions.makeHttpRequest(config);
  
  if (apiResponse.error) {
  console.error(apiResponse.error)
  throw Error("Request failed")
  }
  
  const  {data}  = await apiResponse;
 
  let standingsObj = data.records;
  let standingsString = "";
  for (let x = 0; x < standingsObj.length; x++) {
    if (standingsObj[x].team.slice(0,3) == "Man") { if (standingsObj[x].split(" ")[1]== "United") {addString = "MUN";} else addString="MCI"; 
  standingsString=standingsString+standingsObj[x].team.slice(0,3).toUpperCase()+"/";
  }
   console.log(standingsString);
  return Functions.encodeString(standingsString);