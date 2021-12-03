const main = async () => {
  const text = await Deno.readTextFile("input.txt");

  const listBinaries = text.split("\n");
  // Handle this list like  a matrix, no unnecessary binary operations here....

  let gammaRate = "";

  for (var i = 0; i < listBinaries[0].length; i++) {
    let numOnes = 0;

    for (let row of listBinaries) {
      if (row[i] == "1") {
        numOnes += 1;
      }
    }

    if (listBinaries.length / 2 < numOnes) {
      gammaRate = gammaRate + "1";
    } else {
      gammaRate = gammaRate + "0";
    }
  }

  // Thats how you flip all the bits in a string, and there is no other way!
  let epsilonRate = gammaRate
    .replace(/1/gi, "2")
    .replace(/0/gi, "1")
    .replace(/2/gi, "0");

  console.log(parseInt(gammaRate, 2) * parseInt(epsilonRate, 2));
};

main();
