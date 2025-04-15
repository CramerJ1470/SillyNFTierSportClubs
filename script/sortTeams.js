let Teams = [
  "Arsenal FC",
  "Aston Villa FC",
  "Bournemouth FC",
  "Brentford FC",
  "Brighton FC",
  "Burnley FC",
  "Chelsea FC",
  "Crystal Palace FC",
  "Everton FC",
  "Fulham FC",
  "Liverpool FC",
  "Luton FC",
  "Manchester City FC",
  "Manchester United FC",
  "Newcastle FC",
  "Nottingham Forest FC",
  "Sheffield United FC",
  "Tottenham FC",
  "West Ham FC",
  "Wolves FC",
];

let Abbr = [
  "LIV",
  "ARS",
  "NFO",
  "CHE",
  "MCI",
  "NEW",
  "BHA",
  "FUL",
  "AVL",
  "BOU",
  "BRE",
  "CRY",
  "MUN",
  "TOT",
  "EVE",
  "WHU",
  "WOL",
  "IPS",
  "LEI",
  "SOU",
];

// let sortAbbr = Abbr.sort();

// // const get_premier = async () => {
// //   await fetch("https://www.premierleague.com/tables").then(function(response) {
// //     return response.text();
// //   }).
// //     then(function(res) {
        
     

// //         // const code = { html: res }; //sets a variable to the component
// // 	// console.log(`blockNum: `, blockNum);
// // 	let resBody = res.html;
// //    // Convert response to text
// //   // let parser = new DOMParser();
// //   // 	  let html = parser.parseFromString(html_code, "text/html");
// //   // console.log(html_code); // Logs the HTML source code
//     const els1= resBody.getElementsByClassName("tableContainer")[0]
//     .getElementsByTagName("tbody")[0]
//     .getElementsByTagName("tr");
//   console.log("els1:",els1);

// //   let elsLength = els1.length;
// //   elsNew = [];
// //   for (let j = 0; j < elsLength; j++) {
// //     if (els1[j].getAttribute("data-compseason") == 719) {
// //       elsNew.push(els1[j].getAttribute("data-filtered-table-row-abbr"));
// //     }
// //   }
// //   console.log(typeof res);

//   return res;
//     });
// };

// get_premier();

// Abbr = getDataFromPremier();
// let AbbrString = Abbr.join("");
// let encoded = new TextEncoder().encode(AbbrString);

// console.log("encoded: ", encoded);

// let decodedString = new TextDecoder().decode(encoded).replace(/\0/g, "");
// let standings = [];
// console.log(decodedString);
// for (let c = 0; c < decodedString.length; c++) {
//   if (c % 3 == 0) {
//     standings.push(decodedString.substring(c, c + 3));
//   }
// }
// console.log("standings: ", standings);
// const get_premier = async () => { 
//     return new Promise((resolve, reject) => {
//       https.get("https://www.premierleague.com/tables", (res) => {
//         let data = "";
  
//         res.on("data", (chunk) => {
//           data += chunk;
//         });
  
//         res.on("end", () => {
//           // Use regex to extract team abbreviations
//           const regex = /data-filtered-table-row-abbr="(.*?)"/g;
//           let match;
//           let teamAbbrs = [];
  
//           while ((match = regex.exec(data)) !== null) {
//             teamAbbrs.push(match[1]);
//           }
  
//           console.log("Team Abbreviations:", teamAbbrs);
//           resolve(teamAbbrs);
//         });
//       }).on("error", (err) => {
//         console.error("Error fetching data:", err);
//         reject(err);
//       });
//     });
//   };

//   get_premier();
  console.log(1000000000000000000000000/1e18);
  console.log(13723570800000000/1e18);