const main = async () => {
  const text = await Deno.readTextFile("input.txt");

  let listBinaries = text.split("\n");
  // Handle this list like  a matrix, no unnecessary binary operations here....
  //
  let targetList = listBinaries;

  let currentIndex = 0;

  while (targetList.length != 1) {
    let ones = 0;

    let listOfOnes = [];
    let listOfZeroes = [];

    for (let row of targetList) {
      if (row[currentIndex] == "1") {
        ones += 1;
        listOfOnes.push(row);
      } else {
        listOfZeroes.push(row);
      }
    }

    if (targetList.length / 2 <= ones) {
      targetList = listOfOnes;
    } else {
      targetList = listOfZeroes;
    }
    currentIndex = currentIndex + 1;
  }

  const oxygenLevel = targetList;

  // To the same thing but insert lower matching bit
  targetList = listBinaries;

  currentIndex = 0;

  while (targetList.length != 1) {
    let ones = 0;

    let listOfOnes = [];
    let listOfZeroes = [];

    for (let row of targetList) {
      if (row[currentIndex] == "1") {
        ones += 1;
        listOfOnes.push(row);
      } else {
        listOfZeroes.push(row);
      }
    }

    if (targetList.length / 2 <= ones) {
      targetList = listOfZeroes;
    } else {
      targetList = listOfOnes;
    }
    currentIndex = currentIndex + 1;
  }

  const co2Level = targetList;

  console.log(parseInt(oxygenLevel[0], 2) * parseInt(co2Level[0], 2));
};

main();
