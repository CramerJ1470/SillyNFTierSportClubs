const regex = /\b\w+[a-zA-Z]\s*\w+[a-zA-Z]\b/gm;

(async () => {
    let response = await fetch("https://www.premierleague.com/tables");

let m;

while ((m = regex.exec(str)) !== null) {
    // This is necessary to avoid infinite loops with zero-width matches
    if (m.index === regex.lastIndex) {
        regex.lastIndex++;
    }
    
    // The result can be accessed through the `m`-variable.
    m.forEach((match, groupIndex) => {
        console.log(`Found match, group ${groupIndex}: ${match}`);
    });
}