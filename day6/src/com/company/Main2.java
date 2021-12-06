package com.company;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Main2 {

  public static void main(String[] args) {
    String inputContent = Main2.readInInput();

    ArrayList content =
        new ArrayList(Arrays.stream(inputContent.split(","))
                          .map(x -> BigInteger.valueOf(Integer.parseInt(x)))
                          .collect(Collectors.toList()));

    Main2.simulate(content);
  }

  private static void simulate(ArrayList<BigInteger> fishList) {

    List<BigInteger> lifes = new ArrayList();

    // Init
    for (int i = 0; i <= 8; i++) {
      lifes.add(BigInteger.valueOf(0));
    }

    // Add all fishes
    for (BigInteger fish : fishList) {
      lifes.set(fish.intValue(),
                lifes.get(fish.intValue()).add(BigInteger.valueOf(1)));
    }

    // Is there a smarter vay?
    BigInteger[] empty = {
        BigInteger.valueOf(0), BigInteger.valueOf(0), BigInteger.valueOf(0),
        BigInteger.valueOf(0), BigInteger.valueOf(0), BigInteger.valueOf(0),
        BigInteger.valueOf(0), BigInteger.valueOf(0), BigInteger.valueOf(0)};
    List<BigInteger> newLifes = Arrays.asList(empty.clone());

    for (int i = 0; i < 256; i++) {
      BigInteger zero = BigInteger.valueOf(0);
      for (int j = 8; j >= 0; j--) {
        if (j == 0) {
          newLifes.set(6, lifes.get(j).add(newLifes.get(6)));
          newLifes.set(8, zero);
        } else {
          newLifes.set(j - 1, lifes.get(j));
          if (j == 1) {
            zero = lifes.get(0);
          }
          if (j == 8) {
            lifes.set(8, BigInteger.ZERO);
          }
        }
      }
      // System.out.println(newLifes);
      lifes = newLifes;
      newLifes = Arrays.asList(empty.clone());
    }

    BigInteger sum = BigInteger.ZERO;
    for (BigInteger i : lifes) {
      sum = sum.add(i);
    }
    System.out.println(sum);
  }

  private static String readInInput() {
    Path path = Paths.get("input.txt");

    String inputFile;
    try {
      inputFile = Files.readAllLines(path).get(0);
    } catch (IOException e) {
      inputFile = "";
      e.printStackTrace();
    }

    return inputFile;
  }
}
